import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "NameColumn";
final String emailColumn = "EmailColumn";
final String phoneColumn = "PhoneColumn";
final String imgColumn = "ImgColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath,"contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT"
            "$phoneColumn TEXT. $imgColumn TEXT)"
      );
    });
  }

}

// id name  emal phone   img
// 0  Paulo ..@  500.. /imagens/

class Contact {

  // Adicionar o contato em um MAP... (banco de dados)

  int id;

  String name;
  String email;
  String phone;
  String img;

  // Construtor chamado fromMap, armazenar os dados em formato de mapas
  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,

    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;

  }

  @override
  String toString() {
    return "Contactid (id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}