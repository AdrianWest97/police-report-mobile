import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prms/models/Report.dart';

// ignore: must_be_immutable
class ReportDetails extends StatefulWidget {
  ReportDetails({Key key, @required this.report}) : super(key: key);
  Report report;
  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report details"),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Card(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${widget.report.reference_number.toUpperCase()}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text("Type"),
                    subtitle: Text(widget.report.type.toUpperCase()),
                  ),
                  ListTile(
                    title: Text("Date submmited"),
                    subtitle: Text(DateFormat('EE, dd MMMM')
                        .format(DateTime.parse(widget.report.date))
                        .toString()),
                  ),
                  ListTile(
                    title: Text("Location"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.report.parish),
                        Text(widget.report.city),
                        Text(widget.report.street),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Details"),
                    subtitle: Text(widget.report.details),
                  ),
                  ListTile(
                    title: Text("Witnesses"),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var witness
                              in jsonDecode(widget.report.witnesses))
                            Text("${witness['name']}   #${witness['phone']}")
                        ]),
                  ),
                  ListTile(
                    title: Text("Additional Details"),
                    subtitle: Text(widget.report.additional != null
                        ? widget.report.additional.toString()
                        : '-'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
