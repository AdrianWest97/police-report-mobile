// utils/shared_prefs.dart
import 'package:prms/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get token => _sharedPrefs.getString(keyToken);

  set token(String value) {
    _sharedPrefs.setString(keyToken, value);
  }
}

final sharedPrefs = SharedPrefs();
