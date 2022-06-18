import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return ContactsList();
  }
}

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);

  final ContactDao _dao = ContactDao();
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      //indicando que o future vai receber uma <list<Contact>> (generics)
      body: FutureBuilder<List<Contact>>(
        future: widget._dao.findAll(), //faz busca dos contacts
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              //Ainda fazendo loading mas ja temos dados...
              break;
            case ConnectionState.done:
              //checagem para evitar "null exception"
              if (snapshot.hasData) {
                final contacts = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(
                      contact,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(contact),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
              }
              return const Text('No contacts...');
              break;
          }
          //mesmo que nunca chegue aqui o dart exige um retorno...
          return const Text('Unknown Error');
        },
      ),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => const ContactForm(),
              ),
            )
            .then(
              (value) => update(),
            );
      },
      child: const Icon(Icons.add),
    );
  }

//nojento, pois não temos estado e não estamos usando o Bloc e esta horrivel
//melhoraremos
  update() {
    setState(() {});
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem(this.contact, {required this.onClick}); //contrutor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
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
