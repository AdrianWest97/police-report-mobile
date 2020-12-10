import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';

// ignore: must_be_immutable
class TrackingDetails extends StatefulWidget {
  TrackingDetails({Key key, @required this.refNum}) : super(key: key);
  var refNum;
  @override
  _TrackingDetailsState createState() => _TrackingDetailsState();
}

class _TrackingDetailsState extends State<TrackingDetails> {
  Future<Map<String, dynamic>> details;
  @override
  void initState() {
    super.initState();
    details = _fetchReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Track Report'),
        ),
        body: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var temp = snapshot.data.values.elementAt(index);
                      return Card(
                        child: ListTile(
                          title: Text(
                              DateFormat('dd MMMM')
                                  .format(DateTime.parse(temp['created_at']))
                                  .toString(),
                              style: TextStyle(fontSize: 20)),
                          subtitle: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Text(jsonDecode(temp['data'])['message']
                                    .toString())
                              ],
                            ),
                          ),
                          trailing: FilterChip(
                            label: Text(
                              _getStatus(jsonDecode(temp['data'])['status']
                                  .toString())['value'],
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(_getStatus(
                                jsonDecode(temp['data'])['status']
                                    .toString())['color']),
                            onSelected: (bool newValue) => ({}),
                          ),
                        ),
                      );
                    });
              }
              return Loader();
            },
          ),
        ));
  }

  Future<Map<String, dynamic>> _fetchReport() async {
    var res = await Network().getData('/status/${widget.refNum}');
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body)['reports'] as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  _getStatus(status) {
    switch (status) {
      case 'pending':
        return {"color": 0xfff24805, "value": "Pending"};
      case 'reviewing':
        return {"color": 0xffffe9600, "value": "Reviewing"};

      case 'approved':
        return {"color": 0xfff44236, "value": "Approved"};
    }
  }
}
