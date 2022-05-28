import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  //final List<Contact> contacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    //contacts.add(Contact(0, 'Alex', 1000)); //testar interface...
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      //indicando que o future vai receber uma <list<Contact>>
      body: FutureBuilder<List<Contact>>(
        future: findAll(), //faz busca dos contacts
        builder: (context, snapshot) {
          //checagem para evitar "null exception"
          if (snapshot.hasData) {
            final contacts = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return _ContactItem(contact);
              },
              itemCount: contacts.length,
            );
          }
          return const Text('No contacts...');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then((newContact) => debugPrint(newContact.toString()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem(this.contact); //contrutor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
