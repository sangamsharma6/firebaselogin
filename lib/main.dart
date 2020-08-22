import 'package:firebaselogin/SignInPage.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';
import 'SignUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/SignInPage": (BuildContext context) => SignInPage(),
        "/SignUpPage": (BuildContext context) => SignUpPage(),
      },
    );
  }
}
