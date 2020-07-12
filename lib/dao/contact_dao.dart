import 'package:bytebank_2/database/app_database.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String _tablSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase(_tablSql);
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase(_tablSql);
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Contact> contacts = List();
    _toList(result, contacts);
    return contacts;
  }

  Future<int> update(Contact contact) async {
    final Database db = await getDatabase(_tablSql);
    final Map<String, dynamic> contactMap = _toMap(contact);
    return db.update(
      _tableName,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase(_tablSql);
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void _toList(List<Map<String, dynamic>> result, List<Contact> contacts) {
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_name],
        row[_accountNumber],
        id: row[_id],
      );
      contacts.add(contact);
    }
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }
}
