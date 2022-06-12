import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<Saldo>(builder: (context, valor, child) {
          return Text(
            valor.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          );
        }),
      ),
    );
  }
}
