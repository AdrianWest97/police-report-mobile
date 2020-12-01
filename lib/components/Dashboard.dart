import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prms/models/MenuItem.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<MenuItem> _menu = new List<MenuItem>();
  List<int> _list = [];

  @override
  void initState() {
    _menu.add(
        MenuItem(image: 'assets/svg/report.svg', route: '', title: 'Report'));
    _menu.add(MenuItem(
        image: 'assets/svg/delivery.svg', route: '', title: 'Track Report'));
    _menu.add(MenuItem(
        image: 'assets/svg/search.svg', route: '', title: 'Missing People'));
    _menu.add(MenuItem(
        image: 'assets/svg/location.svg', route: '', title: 'Your Area'));
    _menu.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10),
      childAspectRatio: 1.0,
      mainAxisSpacing: 4.0,
      children: _menu.map((e) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: Card(
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
