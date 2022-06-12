import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard/saldoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
      ),
      body: ListView(
        children: [
          Align(alignment: Alignment.topCenter, child: SaldoCard()),
          Consumer<Saldo>(builder: (context, saldo, child) {
            return ElevatedButton(
              onPressed: () => {saldo.adiciona(10)},
              child: const Text('Adiciona'),
            );
          }),
        ],
      ),
    );
  }
}
