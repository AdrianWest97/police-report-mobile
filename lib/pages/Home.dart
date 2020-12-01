import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/pages/HomeBody.dart';
import 'package:prms/pages/Profile.dart';
import 'package:prms/pages/test.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [HomeBody(), Test(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text("Home", ),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        iconSize: 30,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "",
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
