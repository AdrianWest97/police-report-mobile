import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:prms/pages/Home.dart';
import 'package:prms/pages/new_report.dart';
import 'package:prms/pages/profile_page.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

class CustomNavigatorHomePage extends StatefulWidget {
  CustomNavigatorHomePage({Key key, this.label}) : super(key: key);
  final String label;
  @override
  _CustomNavigatorHomePageState createState() =>
      _CustomNavigatorHomePageState();
}

class _CustomNavigatorHomePageState extends State<CustomNavigatorHomePage> {
  final List<Widget> _children = [
    HomePage(),
    CreateReport(),
    ProfilePage(),
  ];
  Widget _page = HomePage();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    final LoadingBloc loader = Provider.of<LoadingBloc>(context);
    return ModalProgressHUD(
      inAsyncCall: loader.hudLoader,
      opacity: 0.4,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.brown,
          iconSize: 30,
          onTap: (index) {
            navigatorKey.currentState.maybePop();
            setState(() => _page = _children[index]);
            _currentIndex = index;
          },
          currentIndex: _currentIndex,
        ),
        body: CustomNavigator(
          navigatorKey: navigatorKey,
          home: _page,
          pageRoute: PageRoutes.materialPageRoute,
        ),
      ),
    );
  }

  final _items = [
    BottomNavigationBarItem(
      icon: new Icon(Icons.home_filled),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.add_circle_outline),
      label: 'Add',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.account_box_outlined),
      label: 'Profile',
    ),
  ];
}
