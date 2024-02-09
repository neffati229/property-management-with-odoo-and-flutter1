import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:pfe001/register.dart';

import 'acceuil.dart';



// final orpc = OdooClient('http://172.18.15.114:8071/');

final orpc = OdooClient('http://192.168.43.187:8080/');

String login='';
String password='';


// void main() => runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyLogin(),
//     )
// );
class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override

  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int count = 0;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: loginController,

                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,

                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      print(loginController.text);
                                    print(passwordController.text);
                                    count = 0;
                                    try {
                                      await orpc.authenticate(
                                          "locataire_2", loginController.text,
                                          passwordController.text);

                                      login = loginController.text;
                                      password = passwordController.text;
                                      count = 0;
                                      //
                                      Navigator.push(context, MaterialPageRoute(builder: (
                                          context) => acceuil()));
                                    } on OdooException catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Alert Dialog Title"),
                                            content: Text("Alert Dialog Body"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                      print(count);
                                      print('cq');

                                    }

                                    catch(e){
                                      print('error');
                                    }},
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
