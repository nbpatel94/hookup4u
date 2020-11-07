import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/restapi/restapi.dart';

bool select = false;

class SexualOrientation extends StatefulWidget {
  bool generated;
  bool isStatus;

  SexualOrientation({this.generated = false, this.isStatus = false});

  @override
  _SexualOrientationState createState() => _SexualOrientationState();
}

class _SexualOrientationState extends State<SexualOrientation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  snackbar(String text) {
    final snackBar = SnackBar(
      content: Text(
        '$text ',
        style: TextStyle(color: ColorRes.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: ColorRes.redButton,
      duration: Duration(milliseconds: 1500),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  List<Map<String, dynamic>> orientationlist = [
    {'name': 'Single', 'ontap': false},
    {'name': 'Relationship', 'ontap': false},
    {'name': 'Complected', 'ontap': false},
    {'name': 'Married', 'ontap': false},
    {'name': 'Currently Married', 'ontap': false},
    {'name': 'Divorced', 'ontap': false},
    {'name': 'Widowed', 'ontap': false},
    {'name': 'LiveIn', 'ontap': false},
  ];

  List<Map<String, dynamic>> statuslist = [
    {'name': 'No Children', 'ontap': false},
    {'name': 'Have Children', 'ontap': false},
  ];
  List selectedOrientation = [];
  List selectedStatus = [];

  bool isOrientation = false;
  bool isStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isStatus) {
      setState(() {
        isOrientation = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return WillPopScope(
      onWillPop: () async {
        if (isOrientation && !widget.isStatus) {
          setState(() {
            isOrientation = false;
          });
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorRes.primaryColor,
        bottomNavigationBar: Container(
          child: GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                    color: ColorRes.redButton),
                height: MediaQuery.of(context).size.height * .065,
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: Center(
                    child: Text(
                  "CONTINUE",
                  style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ))),
            onTap: () async {
              if (widget.generated) {
                if (widget.isStatus) {
                  if (selectedStatus.isNotEmpty) {
                    appState.status = selectedStatus[0].toString();
                    Navigator.pop(context);
                  } else {
                    snackbar('Select relationship status');
                  }
                } else {
                  if (selectedOrientation.isNotEmpty) {
                    appState.sexualOrientation =
                        selectedOrientation[0].toString();
                    Navigator.pop(context);
                  } else {
                    snackbar('Select sexual orientation');
                  }
                }
              } else {
                if (isOrientation) {
                  if (isStatus) {
                    if (dateOfBirth == 'Date of birth') {
                      snackbar('Select date of birth');
                    } else if (DateTime.now().year - currentYear < 16) {
                      snackbar('Must require 16+');
                    } else {
                      appState.dateOfBirth = dateOfBirth;
                      appState.userDetailsModel.meta.dateOfBirth =
                          appState.dateOfBirth;

                      // print(jsonEncode(appState.userDetailsModel.meta.toJson()));
                      String check = await RestApi.updateUserDetails(
                          appState.userDetailsModel.meta.toFirstJson());
                      if (check == 'success') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListHolderPage()),
                            (Route<dynamic> route) => false);
                      } else {
                        snackbar(
                            'Something went wrong! Try to update after sometime');
                      }
                    }
                  } else {
                    if (selectedStatus.isNotEmpty) {
                      appState.status = selectedStatus[0].toString();
                      appState.userDetailsModel.meta.relation = appState.status;
                      setState(() {
                        isStatus = true;
                      });
                    } else {
                      snackbar('Select relationship status');
                    }
                  }
                } else {
                  if (selectedOrientation.isNotEmpty) {
                    appState.sexualOrientation =
                        selectedOrientation[0].toString();
                    appState.userDetailsModel.meta.sexualOrientation =
                        appState.sexualOrientation;
                    setState(() {
                      isOrientation = true;
                    });
                  } else {
                    snackbar('Select sexual orientation');
                  }
                }
              }
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Text(
                    isStatus
                        ? "Your Birth-Date"
                        :  isOrientation
                                ? "My relationship\nstatus is"
                                : "My sexual\norientation is",
                    style: TextStyle(fontSize: 30, color: ColorRes.white),
                  ),
                  padding: EdgeInsets.only(left: 70, top: 80),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: isStatus
                      ? dateOfBirthDropDown()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: isOrientation
                              ? statuslist.length
                              : orientationlist.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: OutlineButton(
                                highlightedBorderColor: primaryColor,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .055,
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  child: Center(
                                      child: Text(
                                          "${isOrientation ? statuslist[index]["name"] : orientationlist[index]["name"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: ColorRes.textColor,
                                              fontWeight: FontWeight.bold))),
                                ),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: isOrientation
                                        ? statuslist[index]["ontap"]
                                            ? ColorRes.redButton
                                            : ColorRes.darkButton
                                        : orientationlist[index]["ontap"]
                                            ? ColorRes.redButton
                                            : ColorRes.darkButton),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                onPressed: () {
                                  setState(() {
                                    if (isOrientation) {
                                      for (int i = 0;
                                          i < statuslist.length;
                                          i++) {
                                        statuslist[i]["ontap"] = false;
                                      }
                                      statuslist[index]["ontap"] = true;
                                      selectedStatus.clear();
                                      selectedStatus
                                          .add(statuslist[index]["name"]);
                                    } else {
                                      for (int i = 0;
                                          i < orientationlist.length;
                                          i++) {
                                        orientationlist[i]["ontap"] = false;
                                      }
                                      orientationlist[index]["ontap"] = true;
                                      selectedOrientation.clear();
                                      selectedOrientation
                                          .add(orientationlist[index]["name"]);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int currentDay;
  int currentMonth;
  int currentYear;
  String dateOfBirth = 'Date of birth';

  Widget dateOfBirthDropDown() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1960, 1, 1),
            maxTime: DateTime.now(),
            theme: DatePickerTheme(
                headerColor: ColorRes.darkButton,
                backgroundColor: ColorRes.primaryColor,
                itemStyle: TextStyle(
                    color: ColorRes.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                cancelStyle: TextStyle(color: ColorRes.textColor, fontSize: 16),
                doneStyle: TextStyle(color: ColorRes.textColor, fontSize: 16)),
            onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          currentDay = date.day;
          currentYear = date.year;
          currentMonth = date.month;
          dateOfBirth = '${date.day}/${date.month}/${date.year}';
          print('confirm $dateOfBirth');
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                dateOfBirth,
                style: TextStyle(color: ColorRes.textColor, fontSize: 18),
              ),
            ),
            Container(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
