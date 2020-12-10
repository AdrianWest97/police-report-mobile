import 'dart:convert';
import 'dart:ui';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/models/MissingPeople.dart';

class MissingPeople extends StatefulWidget {
  @override
  _MissingPeopleState createState() => _MissingPeopleState();
}

class _MissingPeopleState extends State<MissingPeople> {
  Future<List<Missing>> futureMissingPeople;

  @override
  void initState() {
    super.initState();
    futureMissingPeople = _loadMissing();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Missing People'),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Missing>>(
          future: futureMissingPeople,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              child: CircularProfileAvatar(
                                "${DotEnv().env['BASE_URL']}/storage/${data.image}", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                                radius: 10, // sets radius, default 50.0
                                backgroundColor: Colors
                                    .transparent, //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                                cacheImage:
                                    true, // allow widget to cache image against provided url
                                onTap: () {
                                  print('adil');
                                }, // sets on tap
                              )),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data.fname} ${data.lname}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width,
                                    child: Text(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.parse(data.date))
                                        .toString()),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Loader();
          },
        )));
  }

  Future<List<Missing>> _loadMissing() async {
    final response = await Network().getData('/missing/all');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Missing> _missing = new List<Missing>();

      for (int i = 0; i < jsonDecode(response.body).length; i++) {
        _missing.add(Missing.fromJson(jsonDecode(response.body)[i]));
      }

      return _missing;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
