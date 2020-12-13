import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/models/Report.dart';
import 'package:prms/pages/report_details.dart';

class MyReports extends StatefulWidget {
  @override
  _MyReportsState createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  Future<List<Report>> _reports;
  @override
  void initState() {
    super.initState();
    _reports = _loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Reports'),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Report>>(
          future: _reports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Loader(text: "Just a moment");
            else if (snapshot.hasData && snapshot.data.isNotEmpty) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ReportDetails(report: data))),
                              dense: true,
                              isThreeLine: true,
                              title: Text(
                                "#${data.reference_number.toUpperCase()}",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Details: ${data.details}",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    DateFormat('EE, dd MMMM')
                                        .format(DateTime.parse(data.date))
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  FilterChip(
                                    label: Text(
                                      _getStatus(data.status)['value'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (bool newValue) => ({}),
                                    backgroundColor:
                                        Color(_getStatus(data.status)['color']),
                                  )
                                ],
                              ),
                              trailing: Wrap(
                                spacing: 5.0,
                                runSpacing: 3.0,
                                direction: Axis.vertical,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.delete_outline),
                                          onPressed: () => deleteReport(
                                              data.id, snapshot.data)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            }
            return Center(
              child: Icon(Icons.hourglass_empty),
            );
          },
        )));
  }

  deleteReport(int id, List<Report> data) async {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Are you sure?'),
      content: Text(
          "Are you sure you want to delete this report? This action cannot be undone."),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("Cancel")),
        FlatButton(
            onPressed: () => ({
                  deleteConfirmed(data, id),
                  Navigator.of(context, rootNavigator: true).pop()
                }),
            child: Text("Submit"))
      ],
      elevation: 24.0,
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  deleteConfirmed(List<Report> data, int id) async {
    var res = await Network().deleteData("/report/delete/$id");
    if (res.statusCode == 200) {
      setState(() {
        data.removeWhere((element) => element.id == id);
      });
    } else
      throw Exception('Failed to load album');
  }

  _getStatus(status) {
    switch (status) {
      case 0:
        return {"color": 0xfff24805, "value": "Pending"};
      case 1:
        return {"color": 0xffffe9600, "value": "Reviewing"};

      case 2:
        return {"color": 0xff13BE7A, "value": "Approved"};
    }
  }

  Future<List<Report>> _loadReports() async {
    final response = await Network().getData('/report/all');

    if (response.statusCode == 200) {
      List<Report> reports = new List<Report>();
      for (int i = 0; i < jsonDecode(response.body)['reports'].length; i++) {
        reports.add(Report.fromJson(jsonDecode(response.body)['reports'][i]));
      }
      return reports;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
