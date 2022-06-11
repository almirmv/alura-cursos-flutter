import 'dart:async';
import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionWebClient {
  //Listando todas as transactions via WEB API
  Future<List<Transaction>?>? findAll() async {
    try {
      final http.Response response =
          await client.get(Uri.parse('$baseUrl/transactions'));
      if (response.statusCode == 200) {
        final List<dynamic> decodedJson = jsonDecode(response.body);
        //para cada jsonItem do decodedJson cria uma Transation e transforma em lista
        return decodedJson
            .map((dynamic jsonItem) => Transaction.fromJson(jsonItem))
            .toList();
      }
    } on Exception catch (error) {
      return null;
    }
  }

  //Salvando uma transaction via WEB API
  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    //add delay to test duplicated transfers
    await Future.delayed(const Duration(seconds: 10));

    final http.Response response =
        await client.post(Uri.parse('$baseUrl/transactions'),
            headers: {
              'content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    //ohh nooo...
    if (_statusCodeResponses[response.statusCode] != null) {
      throw Exception(_statusCodeResponses[response.statusCode]);
    }
    throw Exception('Unknown Error');
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    404: 'resource not found on webserver',
    408: 'timeout, request failed',
    409: 'transaction already exists'
  };
}
