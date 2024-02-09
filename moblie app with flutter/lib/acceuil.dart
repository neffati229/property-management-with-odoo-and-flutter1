
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe001/reclamation.dart';

import 'historique.dart';
import 'login.dart';
import 'main.dart';



class acceuil extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);
  Future<dynamic> check() async {
    await orpc.authenticate('locataires',login, password);
  }


  Future<dynamic> fetchContacts() async {
    await check();
    return orpc.callKw({
      'model': 'res.users',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'image_1920',

        ],
        'limit': 80,
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Ma Page d\'accueil'),
        title: Text('Bienvenue Dans notre Espace'),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(

                    backgroundImage: AssetImage('assets/images/user-icon-jpg-22.jpg'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   'Nom d\'utilisateur',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //   ),
                  // ),
                  SizedBox(height: 5),
                  Text(
                    login,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historique des   tickets'),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => respartner()));
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem, color: Colors.red,),
              title: Text('Faire une réclamation'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyForm()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Déconnexion'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyLogin()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.key,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Equipe Helpdesk",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      // child: Text(
                      //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis arcu sed ante tincidunt dictum. Praesent ac pulvinar nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Mauris viverra nisi vitae erat pellentesque, vitae pellentesque nulla auctor. Sed eu orci non enim congue venenatis vel vitae elit. Nullam ac elit sit amet mauris malesuada auctor.",
                      //   textAlign: TextAlign.justify,
                      // ),
                    ),
                    SizedBox(height: 50),
                    CarouselSlider(
                      items: [
                        Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ07l2kis2iuFhiL3RuTGugNPovcTiInscC6pTO1ziSVeqoBksXvL8r2IQ7L8RoYaxVV3k&usqp=CAU'),
                        Image.network('https://adymrxvmro.cloudimg.io/v7/sherpas.com/blog/content/uploads/2023/03/Couverture-plombier.jpeg'),
                        Image.network('https://static.needhelp.fr/photojobbing/40-1637143662.jpeg'),
                        Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0cokFBAvd-p4vxl1lC4njO5RtL9UETM6LLg&usqp=CAU'),
                      ],
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16/9,
                        onPageChanged: (index, reason) {
                          print('Page changed to index $index');
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.flash_on),
                      title: Text('Rapidite'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle),
                      title: Text('Disponibilite'),
                    ),
                    ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text('Garantie'),
                    ),
                    ListTile(
                      leading: Icon(Icons.thumb_up),
                      title: Text('Efficacite'),
                    ),

                  ],

                ),

              ),



            ),



            SizedBox(height: 20),
            // ElevatedButton(
            //
            //   onPressed: () {},
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 15),
            //     child: Text(
            //       'Commencer',
            //       style: TextStyle(
            //         fontSize: 18,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}