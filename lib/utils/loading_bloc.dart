import 'package:flutter/cupertino.dart';

class LoadingBloc extends ChangeNotifier {
  bool _hudLoading = false;
  bool get hudLoader => _hudLoading;

  set loading(bool loader) {
    _hudLoading = loader;
    notifyListeners();
  }
}
