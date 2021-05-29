import 'package:agenda_contatos/home/contact_page.dart';
import 'package:agenda_contatos/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      debugShowCheckedModeBanner: false,
      home: ContactPage(), //Tela principal
    );
  }
}