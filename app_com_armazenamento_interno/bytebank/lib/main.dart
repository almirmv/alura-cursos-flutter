import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: Column(
          children: [
            Image.asset('images/bytebank_logo.png'),
            Container(
              height: 120,
              width: 100,
              color: Colors.green,
              child: Column(
                children: [Icon(Icons.people), Text('Contacts')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
