import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:prms/app.dart';
import 'package:prms/pages/Home.dart';
import 'package:prms/pages/login_page.dart';
import 'package:prms/utils/currentUser.dart';
import 'package:provider/provider.dart';

import 'components/loading.dart';

enum AuthStatus { notLoggedIn, loggedIN }

class AuthRoot extends StatefulWidget {
  @override
  _AuthRootState createState() => _AuthRootState();
}

class _AuthRootState extends State<AuthRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String success = await _currentUser.fetchUser();
    if (success == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginPage();
        break;
      case AuthStatus.loggedIN:
        retVal = CustomNavigatorHomePage();
        break;
      default:
    }
    return retVal;
  }
}
