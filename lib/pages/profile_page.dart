import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/models/user.dart';
import 'package:prms/pages/logout.dart';
import 'package:prms/api/helper.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> futureUser;
  @override
  void initState() {
    super.initState();
    futureUser = _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CircularProfileAvatar(
                            '',
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            borderWidth: 10,
                            initialsText: Text(
                              _getName(snapshot.data.name),
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            borderColor: Colors.red,
                            elevation: 0,
                            showInitialTextAbovePicture: false,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            snapshot.data.name,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
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
                                subtitle: Text(snapshot.data.email),
                                title: Text("Email:"),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text("Phone:"),
                                subtitle: Text(snapshot.data.phoneno != null
                                    ? snapshot.data.phoneno
                                    : ""),
                              ),
                              ListTile(
                                leading: Icon(Icons.map_rounded),
                                title: Text("Addresss:"),
                                subtitle: Wrap(
                                  children: [
                                    Text(snapshot.data.street != null
                                        ? snapshot.data.street
                                        : ""),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(snapshot.data.parish != null
                                        ? snapshot.data.parish
                                        : ""),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(snapshot.data.city != null
                                        ? snapshot.data.city
                                        : "")
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
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.red[400],
                            ),
                            title: InkWell(
                              onTap: () => Logout().logout(context),
                              child: Text("Logout"),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Loader();
              }),
        ));
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

  Future<User> _fetchUser() async {
    final response = await Network().getData('/user');
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginPage(), maintainState: false));
    } else {
      throw Exception('Failed to load profile');
    }
    return null;
  }
}
