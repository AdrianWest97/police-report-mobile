import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prms/api/api.dart';
import 'package:prms/constants/strings.dart';
import 'package:prms/models/Witness.dart';
import 'package:prms/models/report_form.dart';
import 'package:prms/pages/Home.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

import '../root.dart';

class CreateReport extends StatefulWidget {
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport>
    with AutomaticKeepAliveClientMixin {
  int _currentStep = 0;
  //form data
  String reportType;
  List _reportTypes = [
    "Crime Inccident",
    "Vehicle Accident",
    "Covid-19 Breach",
    "Other"
  ];
  DateTime tempDate;
  var _dateController = TextEditingController();
  var _cityController = TextEditingController();
  var _streetController = TextEditingController();
  var _detailsController = TextEditingController();
  var _tempPhone = TextEditingController();
  var _tempName = TextEditingController();
  bool isAnonymous = false;
  List<Witness> _witnesses = new List<Witness>();
  String parish;
  bool hasWitness = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LoadingBloc loadingBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadingBloc = Provider.of<LoadingBloc>(context);
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ))
          ],
          title: Text(
            'Quick Report',
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stepper(
            steps: _reportSteps(),
            currentStep: _currentStep,
            onStepTapped: (step) => goto(step),
            onStepContinue: next,
            onStepCancel: cancel,
            physics: ClampingScrollPhysics(),
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: onStepContinue,
                    child: this._currentStep == _reportSteps().length
                        ? const Text('FINISH')
                        : const Text('NEXT'),
                  ),
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('PREVIOUS'),
                  ),
                ],
              );
            },
          ),
        ));
  }

  void goto(step) {
    setState(() {
      this._currentStep = step;
    });
  }

  void cancel() {
    setState(() {
      if (this._currentStep > 0) {
        this._currentStep = this._currentStep - 1;
      } else {
        this._currentStep = 0;
      }
    });
  }

  void next() {
    setState(() {
      if (this._currentStep < this._reportSteps().length - 1) {
        this._currentStep = this._currentStep + 1;
      } else {
        //step complete
        final FormState formSate = _formKey.currentState;
        if (!formSate.validate()) {
          final scaffold = Scaffold.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: Text("Please required fields"),
              action: SnackBarAction(
                label: 'close',
                onPressed: () {
                  //some action
                },
              ),
            ),
          );
        } else {
          //show popup for confirmation
          formSate.save();
          confirmSubmit(context);
        }
      }
    });
  }

  void confirmSubmit(BuildContext context) {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Submit Report?'),
      content: Text(
          "By clicking submit, you certify that all the given information is true and correct."),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("Cancel")),
        FlatButton(onPressed: () => submitForm(), child: Text("Submit"))
      ],
      elevation: 24.0,
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  List<Step> _reportSteps() {
    List<Step> _steps = [
      Step(
          title: Text(
              'Do you want to make this report anonymous? Your user information wont be shown.'),
          content: Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Switch(
                    value: isAnonymous,
                    onChanged: (value) => setState(() {
                          isAnonymous = value;
                        })),
                Text("Anonymous report?"),
                IconButton(icon: Icon(Icons.help), onPressed: null)
              ],
            ),
          ),
          state: _checkState(0),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Report type & Date'),
          content: _stepOne(),
          state: _checkState(1),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Location of Inccident'),
          content: _stepTwo(),
          state: _checkState(2),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Description of inccident'),
          content: _stepThree(),
          state: _checkState(3),
          isActive: _currentStep >= 0),
    ];
    return _steps;
  }

  _stepTwo() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: DropdownButtonFormField(
              hint: Text("Select Parish"),
              decoration: InputDecoration.collapsed(hintText: ''),
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
              validator: (value) =>
                  value == null ? 'Please select an item' : null,
              items: parishes.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            )),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "This field is required";
            } else {
              return null;
            }
          },
          controller: _cityController,
          decoration: InputDecoration(
            labelText: "City",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "This field is required";
            } else {
              return null;
            }
          },
          controller: _streetController,
          decoration: InputDecoration(
            labelText: "Street Address",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        )
      ],
    );
  }

  _stepThree() {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "This field is required";
            } else {
              return null;
            }
          },
          controller: _detailsController,
          decoration: InputDecoration(
            labelText: "Details",
            hintText: "Give brief information of the inccident",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
          maxLines: null,
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 16,
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Checkbox(
                checkColor: Colors.green,
                activeColor: Colors.grey[300],
                value: hasWitness,
                onChanged: (bool newValue) {
                  setState(() {
                    hasWitness = newValue;
                  });
                },
              ),
              title: Text('Were there any witnesses?'),
            )),
        hasWitness
            ? Column(
                children: [
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: _witnesses.map((e) {
                      return FilterChip(
                        label: Text(e.name),
                        onSelected: null,
                        backgroundColor: Color(0xffededed),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: _tempName,
                    decoration: InputDecoration(
                      labelText: 'Witness full name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _tempPhone,
                    decoration: InputDecoration(
                      labelText: 'Phone #',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () => setState(() {
                              _witnesses.add(Witness(
                                  name: _tempName.text,
                                  phone: _tempPhone.text));
                            })),
                  )
                ],
              )
            : Text('')
      ],
    );
  }

  _stepOne() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: DropdownButtonFormField(
              hint: Text("Select report type"),
              decoration: InputDecoration.collapsed(hintText: ''),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              isExpanded: true,
              value: reportType,
              onChanged: (newValue) async {
                setState(() {
                  reportType = newValue;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select an item' : null,
              items: _reportTypes.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            )),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          validator: (value) {
            if (value == null) {
              return "This field is required";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: 'Select Date',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
          readOnly: true,
          showCursor: false,
          controller: _dateController,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: tempDate == null ? DateTime.now() : tempDate,
                    firstDate: DateTime(2001),
                    lastDate: DateTime.now())
                .then((value) => {
                      setState(() {
                        tempDate = value;
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(tempDate);
                      })
                    });
          },
        )
      ],
    );
  }

  StepState _checkState(int i) {
    if (_currentStep >= i)
      return StepState.complete;
    else
      return StepState.disabled;
  }

  @override
  bool get wantKeepAlive => true;

  submitForm() async {
    Navigator.of(context, rootNavigator: true).pop();
    loadingBloc.loading = true;
    ReportForm form = new ReportForm(
        type: reportType,
        date: _dateController.text,
        city: _cityController.text,
        parish: parish,
        street: _streetController.text,
        anonymous: isAnonymous,
        accepted_terms: true,
        witnesses: jsonEncode(_witnesses),
        details: _detailsController.text,
        hasWitness: hasWitness);
    try {
      var res = await Network().postData(form.toJson(), '/create');
      print(res.body);
      _showSuccessDialog(context, json.decode(res.body)['reference_number']);
    } catch (e) {
      print(e);
    }
    loadingBloc.loading = false;
  }

  void _showSuccessDialog(BuildContext context, body) {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Success"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Your report has been submmited for review and approval. Save this reference number to track your report.",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "REF#",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            body.toString().toUpperCase(),
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          )
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () => {
                  Navigator.of(context, rootNavigator: true)
                      .popAndPushNamed('/'),
                },
            child: Text("OK")),
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: alertDialog);
        });
  }
}
