import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prms/api/api.dart';
import 'package:prms/models/user.dart';

class CurrentUser extends ChangeNotifier {
  User user;

  User get currentUser => user;

  Future<String> fetchUser() async {
    var retVal = "error";
    try {
      final response = await Network().getData('/user');
      if (response.statusCode == 200) {
        retVal = "success";
        user = User.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<bool> signOut() async {
    bool success = false;
    try {
      var res = await Network().postData('', '/logout');
      if (res.statusCode == 200) {
        success = true;
      }
    } catch (e) {
      print(e);
    }
    return success;
  }
}
