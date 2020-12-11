import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/root.dart';
import 'package:prms/utils/SharedPrefs.dart';
import 'package:prms/api/api.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool _isHidden = true;

  LoadingBloc loadingBloc;

  bool isAuthenticating = false;
  @override
  Widget build(BuildContext context) {
    loadingBloc = Provider.of<LoadingBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: loadingBloc.hudLoader,
        opacity: 0.9,
        color: Color(0xFF072e6f),
        progressIndicator: Loader(
          text: "Authenticating...",
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Welcome,",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Login to continue!",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: AbsorbPointer(
                      absorbing: isAuthenticating,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                labelText: "Email",
                                hintText: "Enter your Email",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isHidden = !_isHidden;
                                        });
                                      },
                                      icon: Icon(_isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility)),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                  ))),
                          SizedBox(
                            height: 12,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () {
                                //return true if form is valid
                                if (_formKey.currentState.validate()) {
                                  _login();
                                }
                              },
                              padding: EdgeInsets.all(0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color(0xFF072e6f)),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity, minHeight: 50),
                                  child: !isAuthenticating
                                      ? Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          "Logging in...",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBA5E5F)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    loadingBloc.loading = true;
    setState(() {
      isAuthenticating = true;
    });
    var res = await Network().postData(
        {'email': emailController.text, 'password': passwordController.text},
        '/login');
    if (res.statusCode == 200) {
      sharedPrefs.token = res.body;
      Navigator.pushNamed(context, '/');
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(jsonDecode(res.body)['errors']['email'][0].toString()),
          action: SnackBarAction(
            label: 'close',
            onPressed: () {
              //some action
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthRoot()),
                  (route) => false);
            },
          ),
        ),
      );
    }
    setState(() {
      isAuthenticating = false;
    });
    loadingBloc.loading = false;
  }
}
