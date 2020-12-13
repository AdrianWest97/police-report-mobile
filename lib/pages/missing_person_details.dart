import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MissingPersonDetails extends StatefulWidget {
  MissingPersonDetails({Key key, @required this.report}) : super(key: key);
  var report;

  // @override
  _MissingPersonDetailsState createState() => _MissingPersonDetailsState();
}

class _MissingPersonDetailsState extends State<MissingPersonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.report.name),
      ),
      body: SafeArea(
          child: Container(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              height: 200,
                              child: CircularProfileAvatar(
                                "${DotEnv().env['BASE_URL']}/storage/${widget.report.image}", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                                radius: 10, // sets radius, default 50.0
                                backgroundColor: Colors
                                    .transparent, //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                                cacheImage:
                                    true, // allow widget to cache image against provided url
                                onTap: () {
                                  print('adil');
                                }, // sets on tap
                              ),
                            )),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      widget.report.headline != null
                                          ? widget.report.headline
                                          : "",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "Last Seen: " +
                                            (DateFormat('EE, dd MMMM')
                                                .format(DateTime.parse(
                                                    widget.report.lastSeenDate))
                                                .toString()),
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListTile(
                                    title: Text("Last Seen deatails"),
                                    subtitle: Text(
                                      "${widget.report.details}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]))))),
    );
  }
}
