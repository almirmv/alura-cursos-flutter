import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

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

Future<List<Transaction>>? findAll() async {
  final http.Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
  final http.Response response = await client
      .get(Uri.parse('http://192.168.3.107:8080/transactions'))
      .timeout(
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
