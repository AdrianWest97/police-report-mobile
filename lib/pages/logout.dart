import 'package:flutter/material.dart';
import 'package:prms/api/api.dart';
import 'package:prms/pages/login_page.dart';
import 'package:prms/utils/SharedPrefs.dart';

class Logout {
  logout(BuildContext context) async {
    try {
      await Network().postData('', '/logout');
      sharedPrefs.token = '';
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginPage(), maintainState: false));
    } catch (err) {
      print("could not logout");
      print(err);
    }
  }
}
