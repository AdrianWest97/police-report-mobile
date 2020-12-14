import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/models/user.dart';
import 'package:prms/root.dart';
import 'package:prms/utils/currentUser.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _darkMode = false;
  bool loading = true;
  User user;
  CurrentUser _currentUser;
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    var user = _currentUser.user;
    return !loading
        ? Scaffold(
            body: SafeArea(
                child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Stack(children: [
                    CircularProfileAvatar(
                      '',
                      radius: 40,
                      backgroundColor: Color(0xFFBA5E5F),
                      borderWidth: 10,
                      initialsText: Text(
                        _getName(user.name),
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      borderColor: Color(0xFFBA5E5F),
                      elevation: 0,
                      showInitialTextAbovePicture: false,
                    ),
                  ]),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.email),
                        subtitle: Text(user.email),
                        title: Text("Email:"),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Phone:"),
                        subtitle:
                            Text(user.phoneno != null ? user.phoneno : ""),
                      ),
                      ListTile(
                        leading: Icon(Icons.map_rounded),
                        title: Text("Addresss:"),
                        subtitle: Wrap(
                          children: [
                            Text(user.street != null ? user.street : ""),
                            SizedBox(
                              width: 5,
                            ),
                            Text(user.parish != null ? user.parish : ""),
                            SizedBox(
                              width: 5,
                            ),
                            Text(user.city != null ? user.city : "")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      child: ListTile(
                        onTap: () async {},
                        leading: Icon(
                          Icons.brightness_4,
                        ),
                        title: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Dark Mode",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                                child: Switch(
                                    value: _darkMode,
                                    onChanged: (value) {
                                      setState(() {
                                        _darkMode = value;
                                      });
                                      AdaptiveTheme.of(context)
                                          .toggleThemeMode();
                                    }))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        onTap: () async {
                          bool success = await _currentUser.signOut();
                          if (success) {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => AuthRoot(),
                                    maintainState: false));
                          }
                        },
                        leading: Icon(
                          Icons.power_off,
                          color: Colors.red[400],
                        ),
                        title: Text(
                          "Sign Out",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )))
        : Loader();
  }

  String _getName(String name) {
    var sp = name.split(' ');
    var fullname = "";
    if (sp.length > 0) {
      sp.forEach((element) {
        fullname = fullname + element.substring(0, 1);
      });
    }
    return fullname;
  }

  checkAuth() async {
    _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String retVal = await _currentUser.fetchUser();
    if (retVal == 'success') {
      setState(() {
        loading = false;
      });
    }
  }
}
