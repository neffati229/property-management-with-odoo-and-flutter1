import 'dart:io';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:http_parser/http_parser.dart';
import 'historique.dart';
import 'login.dart';
import 'main.dart';

String name = '';
String description = '';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  Future<dynamic> check() async {
    final orpc = OdooClient('http://192.168.43.187:8080/');

    await orpc.authenticate('locataire_2', login, password);
  }

  Future<dynamic> createTicket(String name, String description ) async {

    return orpc.callKw({
      'model': 'helpdesk.ticket',
      'method': 'create',
      'args': [
        {
          'name': name,
          'description': description,
        }
      ],
      'kwargs': {},
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[20],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Réclamer'),
      ),
      body: Padding(

        padding: EdgeInsets.all(20),

        child: Form(


          // key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40), // Espacement de 20 pixels

              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                maxLines: 4, // Permet à l'utilisateur de saisir jusqu'à 3 lignes de texte
              ),

              SizedBox(height: 20),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  name = nameController.text;
                  description  = descriptionController.text;

                  print(name);
                  print(description);
                  createTicket(name,description);

                  // Navigator.push(context, MaterialPageRoute(builder:(context) => respartner()));
                  if (_formKey.currentState!.validate()) {
                    // Submit the form
                    String name = nameController.text;
                    String description = descriptionController.text;
                    // String bail = bailsController.text;

                    print('Name: $name');
                    print('Description: $description');


                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}