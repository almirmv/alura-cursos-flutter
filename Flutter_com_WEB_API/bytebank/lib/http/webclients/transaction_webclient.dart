import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionWebClient {
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

    if (response.statusCode == 200) {
      return _toTransactions(response);
    }
    throw ("Connection error!"); // error thrown
  }

  //Salvando uma transaction via WEB API
  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final http.Response response =
        await http.post(Uri.parse('$baseUrl/transactions'),
            headers: {
              'content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson);

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(http.Response response) {
    final List<Transaction> transactions = List.empty(growable: true);
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
    return transactions;
  }

  //http response to transaction
  Transaction _toTransaction(http.Response response) {
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

  //transaction to map<string>
  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }
}
