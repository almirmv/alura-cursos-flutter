import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  //getdatabasepath retorna um Future<String> que pegamos com then
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    //contactMap['id'] = contact.id;
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap); //retorna id gerado na inserção
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    //retorna Future<List<Map<String,dynamic>>>
    return db.query('contacts').then((maps) {
      //criar lista de contatos vazia e expansivel
      final List<Contact> contacts = List.empty(growable: true);
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact); //adiciona na lista o novo contato
      }
      return contacts;
    });
  });
}
