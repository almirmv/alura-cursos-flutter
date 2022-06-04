import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
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
    throw ("Connection error: findAll()"); // error thrown
  }

  //Salvando uma transaction via WEB API
  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final http.Response response = await client
        .post(Uri.parse('$baseUrl/transactions'),
            headers: {
              'content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson)
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    if (response.statusCode == 200) {
      return _toTransaction(response);
    }
    throw ("Connection error: save()"); // error thrown
  }

  List<Transaction> _toTransactions(http.Response response) {
    final List<Transaction> transactions = List.empty(growable: true);
    final List<dynamic> decodedJson = jsonDecode(response.body);

    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  //http response to transaction
  Transaction _toTransaction(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
