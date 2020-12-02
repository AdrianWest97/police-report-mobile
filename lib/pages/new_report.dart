import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prms/models/Witness.dart';
import 'package:prms/models/report_form.dart';
import 'package:prms/pages/report.dart';

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
  List<Witness> _witnesses = new List<Witness>();
  String parish;
  bool hasWitness = false;
  List _parishes = [
    "Hanover",
    "St. Elizabeth",
    "St. James",
    "Trelawny",
    "Westmoreland",
    "Clarendon",
    "Manchester",
    "St. Ann",
    "St. Catherine",
    "St. Mary",
    "Kingston",
    "Portland",
    "St. Andrew",
    "St. Thomas"
  ];
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('New Report'),
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
      title: Text('Submit Report?'),
      content: Text(
          "By clicking submit, you certify that all the given information is true and correct."),
      actions: [
        FlatButton(onPressed: null, child: Text("Cancel")),
        FlatButton(onPressed: () => submitForm(), child: Text("Submit"))
      ],
      elevation: 24.0,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  List<Step> _reportSteps() {
    List<Step> _steps = [
      Step(
          title: Text('Report type & Date'),
          content: _stepOne(),
          state: _checkState(0),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Location of Inccident'),
          content: _stepTwo(),
          state: _checkState(1),
          isActive: _currentStep >= 0),
      Step(
          title: Text('Description of inccident'),
          content: _stepThree(),
          state: _checkState(2),
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
                border: Border.all(color: Colors.grey, width: 1),
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
              items: _parishes.map((item) {
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
              title: Text('Where there any witness?'),
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
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                border: Border.all(color: Colors.grey, width: 1),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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

  submitForm() {
    ReportForm form = new ReportForm(
        type: reportType,
        // date: tempDate,
        city: _cityController.text,
        parish: parish,
        street: _streetController.text,
        accepted_terms: true,
        witnesses: _witnesses,
        details: _detailsController.text,
        hasWitness: hasWitness);

    // print(jsonEncode(form.toJson()));
  }
}

class _customDropDown extends StatefulWidget {
  _customDropDown({
    Key key,
    @required this.value,
    @required this.hint,
    @required List items,
  })  : _items = items,
        super(key: key);

  String value;
  String hint;
  List _items;

  @override
  __customDropDownState createState() => __customDropDownState();
}

class __customDropDownState extends State<_customDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonFormField(
        hint: Text(widget.hint),
        decoration: InputDecoration.collapsed(hintText: ''),
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 36,
        isExpanded: true,
        value: widget.value,
        onChanged: (newValue) async {
          setState(() {
            widget.value = newValue;
          });
        },
        validator: (value) => value == null ? 'Please select an item' : null,
        items: widget._items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
