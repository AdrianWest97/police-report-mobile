import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReport extends StatefulWidget {
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('New Report'),
        ),
        body: Center(
          child: Text("Create Report"),
        ));
  }
}
