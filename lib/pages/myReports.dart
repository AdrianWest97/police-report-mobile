import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReports extends StatefulWidget {
  @override
  _MyReportsState createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('My Reports'),
        ),
        body: Center(
          child: Text("My Report"),
        ));
  }
}
