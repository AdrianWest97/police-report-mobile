import 'package:flutter/material.dart';
import 'package:prms/app.dart';
import 'package:prms/pages/login_page.dart';
import 'package:prms/pages/missing_people.dart';
import 'package:prms/pages/report.dart';
import 'package:prms/pages/signup_page.dart';
import 'package:prms/pages/tracking_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => CustomNavigatorHomePage());
      case '/report':
        return MaterialPageRoute(builder: (_) => Report());
      case '/login':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/missing':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => MissingPeople());

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
