import 'package:flutter/material.dart';
import 'package:pfe001/login.dart';
import 'package:pfe001/register.dart';
import 'package:pfe001/register.dart';
import 'package:pfe001/register.dart';
import 'login.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
    },
  ));
}