import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/components/ReportMenu.dart';

class Report extends StatefulWidget {
  const Report({Key key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: ReportMenu()),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
