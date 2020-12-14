import 'package:flutter/cupertino.dart';
import 'package:prms/pages/report.dart';

class ReportBlock extends ChangeNotifier {
  List<Report> _reports;
  List<Report> get reportList => _reports;

  set rList(List<Report> reports) {
    _reports = reports;
    notifyListeners();
  }
}
