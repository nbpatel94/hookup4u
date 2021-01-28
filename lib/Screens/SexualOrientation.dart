import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:intl/intl.dart';

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

  List<Map<String, dynamic>> relationshiplist = [
    {'name': 'Single', 'ontap': false},
    {'name': 'Relationship', 'ontap': false},
    {'name': 'Complected', 'ontap': false},
    {'name': 'Married', 'ontap': false},
    {'name': 'Currently Married', 'ontap': false},
    {'name': 'Divorced', 'ontap': false},
    {'name': 'Widowed', 'ontap': false},
    {'name': 'LiveIn', 'ontap': false},
  ];

  List<Map<String, dynamic>> childrenlist = [
    {'name': 'No Children', 'ontap': false},
    {'name': 'Have Children', 'ontap': false},
  ];
  List selectedRelationship = [];
  List selectedChildren = [];

  bool isRelation = false;
  bool isChild = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return WillPopScope(
      onWillPop: () async {
        if (isRelation && !widget.isStatus) {
          setState(() {
            isRelation = false;
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
                    child: isLoading ?
                    Padding(child: CircularProgressIndicator(backgroundColor: ColorRes.primaryColor,),padding: EdgeInsets.all(5),)
                        :
                    Text(
                  "CONTINUE",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'NeueFrutigerWorld',
                      color: ColorRes.white,
                      fontWeight: FontWeight.bold),
                ))),
            onTap: ()  async {

          /*    Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListHolderPage()),
                      (Route<dynamic> route) => false);*/

              if (widget.generated) {
                if(!isRelation){
                  if (selectedRelationship.isNotEmpty) {
                    appState.relation = selectedRelationship[0].toString();
                    appState.userDetailsModel.meta.relation = appState.relation;
                    setState(() {
                      if(appState.relation=='Married' ||
                          appState.relation=='Currently Married' ||
                          appState.relation=='Divorced' ||
                          appState.relation=='Widowed' ) {
                        isRelation = true;
                        isChild = false;
                      } else {
                        Navigator.pop(context);
                      }
                    });
                  }
                  else {
                    snackbar('Select relationship');
                  }
                }
                else if(!isChild){
                  if (selectedChildren.isNotEmpty) {
                    appState.children = selectedChildren[0].toString();
                    appState.userDetailsModel.meta.children = appState.children;
                    setState(() {
                        isChild = true;
                    });
                    Navigator.pop(context);
                  } else {
                    snackbar('Select relationship');
                  }
                }
              }
              else {
                if(!isRelation){
                  if (selectedRelationship.isNotEmpty) {
                    appState.relation = selectedRelationship[0].toString();
                    appState.userDetailsModel.meta.relation = appState.relation;
                    setState(() {
                      if(appState.relation=='Married' ||
                          appState.relation=='Currently Married' ||
                          appState.relation=='Divorced' ||
                          appState.relation=='Widowed' ) {
                        isRelation = true;
                        isChild = false;
                      }else{
                        isRelation = true;
                        isChild = true;
                      }
                    });
                  } else {
                    snackbar('Select relationship');
                  }
                }
                else if(!isChild){
                  if (selectedChildren.isNotEmpty) {
                    appState.children = selectedChildren[0].toString();
                    appState.userDetailsModel.meta.children = appState.children;
                    setState(() {
                      isChild = true;
                    });
                  } else {
                    snackbar('Select relationship');
                  }
                }
                else{
                  if (dateOfBirth == 'Date of birth') {
                    snackbar('Select date of birth');
                  } else if (DateTime.now().year - currentYear < 16) {
                    snackbar('Must require 16+');
                  } else {
                    print("11");
                    setState(() {
                      isLoading = true;
                    });
                    appState.dateOfBirth = dateOfBirth;
                    appState.userDetailsModel.meta.dateOfBirth =
                        appState.dateOfBirth;

                    // print(jsonEncode(appState.userDetailsModel.meta.toJson()));
                    String check = await RestApi.updateUserDetails(appState.userDetailsModel.meta.toFirstJson());
                      isLoading = true;
                    if (check == 'success') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListHolderPage()),
                              (Route<dynamic> route) => false);
                    } else {
                      snackbar('Something went wrong! Try to update after sometime');
                    }
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
                    !isRelation
                        ? "My relationship\nstatus is"
                        : !isChild
                            ? "Children"
                            : "My Birth Date",
                    style: TextStyle(fontSize: 30,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w100, color: ColorRes.white),
                  ),
                  padding: EdgeInsets.only(left: 70, top: 80),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: !isRelation
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: relationshiplist.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: OutlineButton(
                                highlightedBorderColor: ColorRes.primaryColor,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .055,
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  child: Center(
                                      child: Text(
                                          "${relationshiplist[index]["name"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'NeueFrutigerWorld',
                                              color: ColorRes.textColor,
                                              fontWeight: FontWeight.bold))),
                                ),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: relationshiplist[index]["ontap"]
                                        ? ColorRes.redButton
                                        : ColorRes.darkButton),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0;
                                        i < relationshiplist.length;
                                        i++) {
                                      relationshiplist[i]["ontap"] = false;
                                    }
                                    relationshiplist[index]["ontap"] = true;
                                    selectedRelationship.clear();
                                    selectedRelationship
                                        .add(relationshiplist[index]["name"]);
                                  });
                                },
                              ),
                            );
                          },
                        )
                      : !isChild
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: childrenlist.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: OutlineButton(
                                    highlightedBorderColor: ColorRes.primaryColor,
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * .055,
                                      width: MediaQuery.of(context).size.width * .65,
                                      child: Center(
                                          child: Text(
                                              "${childrenlist[index]["name"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: ColorRes.textColor,
                                                  fontFamily: 'NeueFrutigerWorld',
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: childrenlist[index]["ontap"]
                                            ? ColorRes.redButton
                                            : ColorRes.darkButton),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0; i < childrenlist.length; i++) {
                                          childrenlist[i]["ontap"] = false;
                                        }
                                        childrenlist[index]["ontap"] = true;
                                        selectedChildren.clear();
                                        selectedChildren.add(childrenlist[index]["name"]);
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          : dateOfBirthDropDown(),
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
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                cancelStyle: TextStyle(color: ColorRes.textColor, fontSize: 16),
                doneStyle: TextStyle(color: ColorRes.textColor, fontSize: 16)),
            onChanged: (date) {
          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {

          currentDay = date.day;
          currentYear = date.year;
          currentMonth = date.month;
          // dateOfBirth  = '${date.day}/${date.month}/${date.year}';
          // print("Hello " + dateOfBirth);

          // final DateTime now = DateTime.now();
          final DateFormat formatter = DateFormat('MMM dd, y');
          final String formatted = formatter.format(date);
          print("confirm" + formatted);

          dateOfBirth = formatted;

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
                style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor, fontSize: 18),
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
