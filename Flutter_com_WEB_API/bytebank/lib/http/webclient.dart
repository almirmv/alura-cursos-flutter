import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = 'http://192.168.3.107:8080';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    //print(data.toString());
    print('Request-------------');
    print('Url: ${data.baseUrl}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    //print(data.toString());
    print('Response------------');
    print('Status Code: ${data.statusCode}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }
}

//para uso do http_interceptor
final http.Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

//Listando todas as transactions via WEB API
Future<List<Transaction>>? findAll() async {
  final http.Response response =
      await client.get(Uri.parse('$baseUrl/transactions')).timeout(
    const Duration(seconds: 5),
    onTimeout: () {
      return http.Response(
          'Error', 408); // Request Timeout response status code
    },
  );
  //criando lista vazia...
  final List<Transaction> transactions = List.empty(growable: true);
  if (response.statusCode == 200) {
    //resposta ok vamos decodificar...
    final List<dynamic> decodedJson = jsonDecode(response.body);

    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    print('decoded JSON: $decodedJson');
    return transactions;
  }
  throw ("Connection error!"); // error thrown
}

//Salvando uma transaction via WEB API
Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);

  final http.Response response =
      await http.post(Uri.parse('$baseUrl/transactions'),
          headers: {
            'content-type': 'application/json',
            'password': '1000',
          },
          body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);

  final Map<String, dynamic> contactJson = json['contact'];
  //devolve uma Transaction com dados de resposta
  return Transaction(
    json['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
