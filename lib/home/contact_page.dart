import 'package:agenda_contatos/helpers/contact_help.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_help.dart';

class ContactPage extends StatefulWidget {
  //const ContactPage({Key key}) : super(key: key);

  final Contact contact;

  //Contrutor
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "Novo Contado"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
    );
  }
}
