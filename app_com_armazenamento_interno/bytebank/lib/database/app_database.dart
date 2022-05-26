import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  //getdatabaepath retirna um Future que pegamos com then
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT'
          'account_number INTEGER)');
    }, version: 1);
  });
}
