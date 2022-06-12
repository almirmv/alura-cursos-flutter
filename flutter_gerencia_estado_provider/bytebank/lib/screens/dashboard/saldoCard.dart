import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';

class SaldoCard extends StatelessWidget {
  final Saldo saldo;

  const SaldoCard(this.saldo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          saldo.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
