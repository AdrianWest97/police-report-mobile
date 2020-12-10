import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
  }) : super(key: key);

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
          "Loading...",
          style: TextStyle(color: Colors.grey),
        )
      ])),
    );
  }
}
