import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(String table) async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(table);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
