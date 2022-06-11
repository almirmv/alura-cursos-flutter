import 'dart:async';
import 'dart:io';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    //print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Progress(
                    message: 'Sending...',
                  ),
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      if (value != null) {
                        final transactionCreated =
                            Transaction(transactionId, value, widget.contact);
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onConfirm: (String password) {
                                  _save(transactionCreated, password, context);
                                },
                              );
                            });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    try {
      setState(() => _sending = true);

      await _webClient.save(transactionCreated, password);
      setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('transaction done');
          }).then((value) => Navigator.pop(context));
    } on TimeoutException catch (error) {
      setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog('timeout submiting transaction');
          });
    } on Exception catch (error) {
      setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(error.toString());
          });
    }
  }
}
