import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  //TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //transactions.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        //future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        future: findAll(),
        builder: (context, snapshot) {
          final List<Transaction>? transactions = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Transaction transaction = transactions![index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.accountNumber.toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions!.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}
