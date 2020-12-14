import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/components/HomeMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          // child: Text(
          //   "Welcome",
          //   style: headingStyle,
          // ),
          child: HomeMenu(),
        ),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
