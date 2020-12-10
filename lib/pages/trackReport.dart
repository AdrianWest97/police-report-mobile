import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/models/Report.dart';
import 'package:prms/pages/tracking_details.dart';

class TrackReport extends StatefulWidget {
  @override
  _TrackReportState createState() => _TrackReportState();
}

class _TrackReportState extends State<TrackReport> {
  Future<List<Report>> _reports;
  @override
  void initState() {
    super.initState();
    _reports = _loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Track Report'),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Report>>(
          future: _reports,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => TrackingDetails(
                                        refNum: data.reference_number))),
                            dense: true,
                            isThreeLine: true,
                            leading: Text(
                              "REF#: ",
                              style: TextStyle(fontSize: 15),
                            ),
                            title: Text(
                              data.reference_number.toUpperCase(),
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Submitted on: ${data.date}",
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
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Loader();
          },
        )));
  }

  Future<List<Report>> _loadReports() async {
    final response = await Network().getData('/all');

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

  _getStatus(status) {
    switch (status) {
      case 0:
        return {"color": 0xfff24805, "value": "Pending"};
      case 1:
        return {"color": 0xffffe9600, "value": "Reviewing"};

      case 2:
        return {"color": 0xfff44236, "value": "Approved"};
    }
  }
}
