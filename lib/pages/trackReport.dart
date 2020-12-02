import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackReport extends StatefulWidget {
  @override
  _TrackReportState createState() => _TrackReportState();
}

class _TrackReportState extends State<TrackReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Track Report'),
        ),
        body: Center(
          child: Text("Trck Report"),
        ));
  }
}
