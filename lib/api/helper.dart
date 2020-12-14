import 'dart:convert';

import 'package:prms/api/api.dart';
import 'package:prms/models/user.dart';

class Helper {
  Future<User> _fetchUser() async {
    final response = await Network().getData('/user');
    if (response.statusCode == 200) {
      User user = jsonDecode(response.body);
      return user;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
