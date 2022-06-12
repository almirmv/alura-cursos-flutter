import 'package:bytebank/screens/dashboard/saldoCard.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
      ),
      body: Align(alignment: Alignment.topCenter, child: SaldoCard()),
    );
  }
}
