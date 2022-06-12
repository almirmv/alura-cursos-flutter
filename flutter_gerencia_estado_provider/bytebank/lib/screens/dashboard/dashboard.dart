import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard/saldoCard.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
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
              child: const Text('Receber Depósito'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormularioDeposito();
                }));
              },
            );
          }),
        ],
      ),
    );
  }
}
