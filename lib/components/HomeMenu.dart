import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prms/models/MenuItem.dart';
import 'package:prms/pages/Home.dart';
import 'package:prms/pages/missing_people.dart';
import 'package:prms/pages/report.dart';
import 'package:prms/pages/trackReport.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List<MenuItem> _menu = new List<MenuItem>();

  @override
  void initState() {
    _menu.add(MenuItem(
        image: 'assets/svg/report.svg', route: Report(), title: 'Report'));
    _menu.add(MenuItem(
        image: 'assets/svg/delivery.svg',
        route: TrackReport(),
        title: 'Track Report'));
    _menu.add(MenuItem(
        image: 'assets/svg/search.svg',
        route: MissingPeople(),
        title: 'Missing People'));
    _menu.add(MenuItem(
        image: 'assets/svg/location.svg',
        route: HomePage(),
        title: 'Your Area'));
    _menu.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(0),
      childAspectRatio: 1.0,
      mainAxisSpacing: 4.0,
      shrinkWrap: true,
      children: _menu.map((e) {
        return InkWell(
          onTap: () => Navigator.push(
              context, new MaterialPageRoute(builder: (context) => e.route)),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    e.image,
                    width: 50,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    e.title,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
