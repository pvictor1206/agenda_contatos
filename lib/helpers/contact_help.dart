import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String idColumn = "idColumn";
final String nameColumn = "NameColumn";
final String emailColumn = "EmailColumn";
final String phoneColumn = "PhoneColumn";
final String imgColumn = "ImgColumn";

class ContactHelper {


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