import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransactionAuthDialog extends StatelessWidget {
  const TransactionAuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 32,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              print('cancel');
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              print('confirm');
            },
            child: const Text('Confirm')),
      ],
    );
  }
}
