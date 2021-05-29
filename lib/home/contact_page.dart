import 'package:agenda_contatos/helpers/contact_help.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_help.dart';
import 'dart:io';

class ContactPage extends StatefulWidget {
  //const ContactPage({Key key}) : super(key: key);

  final Contact contact;

  //Contrutor
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  // Para que serve um controlador?
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();


  Contact _editedContact;

  bool _userEdited = false;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _phoneController.text = _editedContact.phone;
      _emailController.text = _editedContact.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editedContact.name ?? "Novo Contado"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(_editedContact.name != null && _editedContact.name.isNotEmpty){
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _editedContact.img != null ?
                            FileImage(File(_editedContact.img)) :
                            AssetImage("")
                        ),
                      ),
                    )
                ),
                TextField(
                  focusNode: _nameFocus,
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "Nome"
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Email"
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContact.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: "Phone"
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContact.phone = text;
                  },
                  keyboardType: TextInputType.phone,
                ),

              ],
            ),
          ),
        ),
    );
  }

  Future<bool> _requestPop(){
    //Se o usuario editou, mostra um diagulo.
    if(_userEdited){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações seram perdidas."),
              actions: [
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")
                ),
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Sim")
                ),
              ],
            );
          }
      );

    }else{
      return Future.value(true);
    }
  }

}
