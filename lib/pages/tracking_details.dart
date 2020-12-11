import 'dart:convert';
import 'dart:developer';

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
        appBar: AppBar(
          title: Text('Track Report #${widget.refNum.toUpperCase()}'),
        ),
        body: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: TimeLine(
                    data: snapshot.data,
                  ),
                );
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
}

class TimeLine extends StatefulWidget {
  @override
  TimeLine({Key key, @required this.data}) : super(key: key);
  _TimeLineState createState() => _TimeLineState();
  Map<String, dynamic> data;
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            var temp = widget.data.values.elementAt(index);
            return Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.black,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Color(_getStatus(
                                jsonDecode(temp['data'])['status']
                                    .toString())['color']),
                            borderRadius: BorderRadius.circular(50)),
                        child: null,
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EE, dd MMMM')
                                    .format(DateTime.parse(temp['created_at']))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                jsonDecode(temp['data'])['message'].toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              FilterChip(
                                label: Text(
                                  _getStatus(jsonDecode(temp['data'])['status']
                                      .toString())['value'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Color(_getStatus(
                                    jsonDecode(temp['data'])['status']
                                        .toString())['color']),
                                onSelected: (bool newValue) => ({}),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  _getStatus(status) {
    switch (status) {
      case 'pending':
        return {"color": 0xfff24805, "value": "Pending"};
      case 'reviewing':
        return {"color": 0xffffe9600, "value": "Reviewing"};

      case 'approved':
        return {"color": 0xff13BE7A, "value": "Approved"};
    }
  }
}
