import 'package:agenda_contatos/helpers/contact_help.dart';
import 'package:agenda_contatos/home/contact_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index){
          return _contactCard(context, index);
          }
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                        FileImage(File(contacts[index].img)) :
                    AssetImage(""))
                  ),
                ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contacts[index].name ?? "",
                          style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          Text(contacts[index].email ?? "",
                            style: TextStyle(fontSize: 10.0,
                            ),
                          ),
                          Text(contacts[index].phone ?? "",
                            style: TextStyle(fontSize: 10.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
              )
          ]
              )
            ,
          ),
        ),
      onTap: (){
        _showOptions(context, index);
      },
      );

  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
              onClosing: (){

              },
              builder: (context){
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                          onPressed: (){
                            launch("tel:${contacts[index].phone}");
                            Navigator.pop(context);
                          },
                          child: Text("Ligar",
                            style: TextStyle(fontSize: 20.0, color: Colors.red ),
                          )
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: (){
                              Navigator.pop(context);
                              _showContactPage(contact: contacts[index]);
                            },
                            child: Text("Editar",
                              style: TextStyle(fontSize: 20.0, color: Colors.red ),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: (){
                              helper.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Excluir",
                              style: TextStyle(fontSize: 20.0, color: Colors.red ),
                            )
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
    );
  }

  void _showContactPage({Contact contact}) async{
    final recContact = await Navigator.push(context,
    MaterialPageRoute(
        builder: (context) => ContactPage(contact: contact,)
    )
    );
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
      }
      else{
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

}
