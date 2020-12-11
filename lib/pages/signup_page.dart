import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:prms/api/api.dart';
import 'package:prms/components/loading.dart';
import 'package:prms/constants/strings.dart';
import 'package:prms/utils/SharedPrefs.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

import '../root.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isHidden = true;

  bool isAuthenticating = false;

  LoadingBloc loadingBloc;

  var _emailController = TextEditingController();

  var _fullNameController = TextEditingController();

  var _trnController = TextEditingController();

  var _phoneController = TextEditingController();

  var _passwordController = TextEditingController();

  var _cPasswordController = TextEditingController();
  var _cityController = TextEditingController();
  var _streetController = TextEditingController();

  var parish;

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
          text: "Creating your account...",
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
                        height: 20,
                      ),
                      Text(
                        "Create Account,",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Sign up to get started!",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: AbsorbPointer(
                      absorbing: isAuthenticating,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _fullNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: "Name",
                              hintText: "Enter your full name",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: "Email",
                              hintText: "Enter your email address",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: _trnController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    labelText: "TRN",
                                    hintText: "Enter your TRN",
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
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _phoneController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    labelText: "Phone",
                                    hintText: "Enter your phone #",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    return validate(value);
                                  },
                                  obscureText: _isHidden,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isHidden = !_isHidden;
                                          });
                                        },
                                        icon: Icon(_isHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility)),
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w600),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              //confirm password
                              Flexible(
                                child: TextFormField(
                                  controller: _cPasswordController,
                                  validator: (value) {
                                    if (_cPasswordController.text !=
                                        _passwordController.text)
                                      return "Password do not match";
                                    if (value.isEmpty)
                                      return "This is field is required";
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    labelText: "Confirm-Password",
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w600),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(children: [
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: DropdownButtonFormField(
                                    isDense: true,
                                    hint: Text("Select Parish"),
                                    decoration:
                                        InputDecoration.collapsed(hintText: ''),
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: parish,
                                    onChanged: (newValue) async {
                                      setState(() {
                                        parish = newValue;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Please select an item'
                                        : null,
                                    items: parishes.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  )),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: TextFormField(
                                controller: _cityController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  labelText: "City",
                                  hintText: "City",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _streetController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: "Street",
                              hintText: "Enter your street addreess",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
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
                                if (_formKey.currentState.validate()) {
                                  _register();
                                }
                              },
                              padding: EdgeInsets.all(0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFF072e6f)),
                                child: Container(
                                    alignment: Alignment.center,
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50),
                                    child: !isAuthenticating
                                        ? Text(
                                            "Create Account",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )
                                        : Text(
                                            "Processsing",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "I'm already a member.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign in.",
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

  _register() async {
    loadingBloc.loading = true;
    setState(() {
      isAuthenticating = true;
    });
    var res = await Network().postData({
      'email': _emailController.text,
      'password': _passwordController.text,
      'password_confirmation': _cPasswordController.text,
      'trn': _trnController.text,
      'phone': _phoneController.text,
      'name': _fullNameController.text,
      'parish': parish,
      'street': _streetController.text,
      'city': _cityController.text
    }, '/register');
    if (res.statusCode == 200) {
      sharedPrefs.token = res.body;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AuthRoot()),
          (route) => false);
    } else {
      var msg = jsonDecode(res.body)['errors']['email'][0];
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          action: SnackBarAction(
            label: 'close',
            onPressed: () {
              //some action
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

  validate(value) {
    if (value == '') {
      return 'This field is required';
    }
    return null;
  }
}
