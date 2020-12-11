import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prms/models/MenuItem.dart';
import 'package:prms/pages/myReports.dart';
import 'package:prms/pages/new_report.dart';
import 'package:prms/pages/trackReport.dart';

class ReportMenu extends StatefulWidget {
  @override
  _ReportMenuState createState() => _ReportMenuState();
}

class _ReportMenuState extends State<ReportMenu> {
  List<MenuItem> _menu = new List<MenuItem>();

  @override
  void initState() {
    _menu.add(MenuItem(
        image: 'assets/svg/report.svg',
        route: CreateReport(),
        title: 'Create Report',
        text: 'Make a report on a crime, vehicle accident or covid-19 breach'));
    // _menu.add(MenuItem(
    //     image: 'assets/svg/delivery.svg',
    //     route: TrackReport(),
    //     title: 'Track Report',
    //     text: 'Track your report status '));
    _menu.add(
      MenuItem(
          image: 'assets/svg/document.svg',
          route: MyReports(),
          title: 'My Reports',
          text: 'See your recent reports'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _menu.length,
        itemBuilder: (BuildContext context, int index) =>
            menuCard(context, index));
  }

  Widget menuCard(BuildContext context, int index) {
    final item = _menu[index];
    return Container(
      child: InkWell(
        onTap: () => Navigator.push(
            context, new MaterialPageRoute(builder: (context) => item.route)),
        child: Card(
          elevation: 0.2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    item.image,
                    width: 50,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                    child: Column(
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.text,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
