import 'package:flutter/material.dart';
import 'package:prms/pages/Home.dart';
import 'package:prms/pages/login_page.dart';
import 'package:prms/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/register': (context) => SignupPage()
      },
    );
  }
}
