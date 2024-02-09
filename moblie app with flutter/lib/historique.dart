
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:pfe001/reclamation.dart';
// import 'package:flutter_html/flutter_html.dart';

import 'login.dart';
import 'main.dart';


class respartner extends StatelessWidget {
  final orpc = OdooClient('http://192.168.1.18:8071/');
  // final orpc = OdooClient('http://192.168.100.48:8071/');
  // final orpc = OdooClient('http://172.18.15.114:8071/');
  // final orpc = OdooClient('http://172.18.15.197:8071/');

  Future<dynamic> check() async {
    await orpc.authenticate('pfe', login, password);
  }

  Future<dynamic> fetchContacts() async {
    await check();
    return orpc.callKw({
      'model': 'helpdesk.ticket',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name', 'description'.toString(), 'user_id', 'kanban_state', 'bail' , 'date_field'],
        'limit': 80,
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record, BuildContext context) {
    // Ajouter le paramètre context ici
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ArticleDialog(
                key: Key(record['name'].toString()), // Ajouter l'argument key avec une valeur unique
                record: record,
                context: context,
              );
            },
          );
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://picsum.photos/seed/picsum/200/300',
          ),
        ),
        title: Text(
          record['name'],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record['date_field'].toString(),
              style: TextStyle(color: Colors.red),
            ),
            Row(
              children: [
                Text(
                  record['kanban_state'].toString(),
                ),
              ],
            ),
            Row(
              children: [
                // Text(record['user_id'].toString()),
              ],
            )
          ],
        ),
        trailing: Icon(Icons.circle, size: 25,   color: record['kanban_state'] == 'done'
            ? Colors.green
            : record['kanban_state'] == 'normal'
            ? Colors.grey
            : record['kanban_state'] == 'blocked'
            ? Colors.red
            : Colors.blueAccent),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Historique'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyForm()));
              // Code pour naviguer vers une autre page
              // Utilisez la fonction Navigator.push pour naviguer vers une nouvelle page
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchContacts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final record = snapshot.data[index] as Map<String, dynamic>;
                  return buildListItem(
                      record, context); // Passer le context à buildListItem
                },
              );
            } else {
              if (snapshot.hasError) return Text('Unable to fetch data');
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class ArticleDialog extends StatelessWidget {
  final Map<String, dynamic> record;
  final BuildContext context;

  const ArticleDialog({
    required Key key,
    required this.record,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Détails de Votre Ticket : ',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subject:",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                record['name'].toString(),
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Date:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                record['date_field'].toString(),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Text(
                'État:',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                record['kanban_state'].toString(),
                style: TextStyle(
                  color: record['kanban_state'] == 'done'
                      ? Colors.green
                      : record['kanban_state'] == 'normal'
                      ? Colors.grey
                      : Colors.blueAccent,
                  fontSize: 22,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Text(
                "bail:",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                record['bail'].toString(),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Text(
                record['description'].toString(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Fermer'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}