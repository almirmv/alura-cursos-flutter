import 'dart:async';
import 'dart:io';

import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

//classe base para todos os estados
@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class FatalErrorState extends TransactionFormState {
  const FatalErrorState();
}

//Cubit para dizer qual nosso estado
class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(ShowFormState());
}

//Container
class TransactionFormContainer extends BlocContainer {
  final Contact _contact;
  TransactionFormContainer(this._contact);

  //builder para criar o nosso estado
  @override
  Widget build(BuildContext context) {
    //blocProvider que devolve um TransactionFormCubit
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) {
        return TransactionFormCubit();
      },
      child: TransactionFormStateless(_contact), //widget qye sera build
    );
  }
}

class TransactionFormStateless extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  final Contact _contact;
  TransactionFormStateless(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: (context, state) {
      if (state is ShowFormState) {
        return _BasicForm(_contact);
      } else if (state is SendingState) {
        return ProgressView();
      } else if (state is SentState) {
        Navigator.pop(context);
      } else if (state is FatalErrorState) {
        //TODO: tela de erro
      }
      //TODO: tela de erro
      return Text('Error!!!');
    });
  }

  Future<void> _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    try {
      //setState(() => _sending = true);

      await _webClient.save(transactionCreated, password);
      //setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('transaction done');
          }).then((value) => Navigator.pop(context));
    } on TimeoutException catch (error) {
      //setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog('timeout submiting transaction');
          });
    } on Exception catch (error) {
      //setState(() => _sending = false);
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(error.toString());
          });
    }
  }
}

class _BasicForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  final Contact _contact;
  _BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
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
              Text(
                _contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _contact.accountNumber.toString(),
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
                            Transaction(transactionId, value, _contact);
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onConfirm: (String password) {
                                  //TODO: executar o envio
                                  //_save(transactionCreated, password, context);
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
}
