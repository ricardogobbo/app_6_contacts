import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Contact.dart';

class ContactDAO {
  //Singleton Instance
  static final ContactDAO _instance = ContactDAO.internal();

  factory ContactDAO() => _instance;

  ContactDAO.internal();

  // Class attributes and methods

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int nVersion) async {
      await db.execute("CREATE TABLE ${Contact.TABLE_NAME} ( " +
          "${Contact.ID_COLUMN} integer primary key, " +
          "${Contact.NAME_COLUMN} text, " +
          "${Contact.EMAIL_COLUMN} text, " +
          "${Contact.PHONE_COLUMN} text, " +
          "${Contact.IMAGE_COLUMN} text )");
    });
  }

  Future<Contact> save(Contact contact) async {
    return contact.id != null ? this.update(contact) : this.create(contact);
  }

  /// Method : create (async)
  ///
  /// Params : [contact] = contact to be created
  /// Returns: same contact with created id
  Future<Contact> create(Contact contact) async {
    Database db = await database;
    contact.id = await db.insert(Contact.TABLE_NAME, contact.toMap());
    return contact;
  }

  Future<Contact> update(Contact contact) async {
    Database db = await database;
    await db.update(Contact.TABLE_NAME, contact.toMap(),
        where: "${Contact.ID_COLUMN} = ? ", whereArgs: [contact.id]);

    return contact;
  }


  Future<Contact> get(int id) async {
    Database db = await database;
    List<Map> results = await db.query(Contact.TABLE_NAME,
        columns: Contact.ALL_COLUMNS,
        where: "${Contact.ID_COLUMN} = ?",
        whereArgs: [id]);

    if (results.length > 0) {
      return Contact.fromMap(results[0]);
    }

    return null;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(Contact.TABLE_NAME,
        where: "${Contact.ID_COLUMN} = ?", whereArgs: [id]);
  }



  Future<List<Contact>> list({order: 'ASC', sort: Contact.ID_COLUMN}) async {
    Database db = await database;
    List<Map> results =
        await db.query(Contact.TABLE_NAME,
            columns: Contact.ALL_COLUMNS,
            orderBy: "upper($sort) $order");

    List<Contact> list = List();
    for(Map m in results){
      list.add(Contact.fromMap(m));
    }

    return list;
  }

  Future<int> count() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery("COUNT (*)  FROM ${Contact.TABLE_NAME}"));
  }

  Future close() async {
    Database db = await database;
    await db.close();
  }
}
