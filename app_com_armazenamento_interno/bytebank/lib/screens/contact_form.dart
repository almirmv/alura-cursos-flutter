import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameCotroller = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _nameCotroller,
                decoration: InputDecoration(labelText: 'Full Name'),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: onPressed, child: const Text('Create')),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() {
    final String name = _nameCotroller.text;
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    //checagem para evitar "null exception"
    if (name != '' && accountNumber != null) {
      final Contact newContact = Contact(0, name, accountNumber);
      save(newContact).then((id) => Navigator.pop(context));
    }
  }
}
