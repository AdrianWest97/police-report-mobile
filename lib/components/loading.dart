import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Loader({Key key, this.text}) : super(key: key);
  var text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 15.0,
          width: 15.0,
          child: CircularProgressIndicator(strokeWidth: 3.0),
        ),
        SizedBox(height: 10),
        Text(
          text != null ? text.toString() : 'Loading...',
          style: TextStyle(color: Colors.grey),
        )
      ])),
    );
  }
}
