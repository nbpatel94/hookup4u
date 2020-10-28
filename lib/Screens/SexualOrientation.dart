import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/ShowGender.dart';
import 'package:hookup4u/util/color.dart';

bool select = false;

class SexualOrientation extends StatefulWidget {
  @override
  _SexualOrientationState createState() => _SexualOrientationState();
}

List<Map<String, dynamic>> orientationlist = [
  {'name': 'Straight', 'ontap': false},
  {'name': 'Gay', 'ontap': false},
  {'name': 'Asexual', 'ontap': false},
  {'name': 'Lesbian', 'ontap': false},
  {'name': 'Bisexual', 'ontap': false},
  {'name': 'Demisexual', 'ontap': false},
];
List selected = [];

class _SexualOrientationState extends State<SexualOrientation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  snackbar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // floatingActionButton: AnimatedOpacity(
      //   opacity: 1.0,
      //   duration: Duration(milliseconds: 50),
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 90.0),
      //     child: FloatingActionButton(
      //       elevation: 10,
      //       child: IconButton(
      //         color: secondryColor,
      //         icon: Icon(Icons.arrow_back_ios),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       backgroundColor: Colors.white38,
      //       onPressed: () {
      //         dispose();
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  "My sexual\norientation is",
                  style: TextStyle(fontSize: 40),
                ),
                padding: EdgeInsets.only(left: 50, top: 80),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orientationlist.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OutlineButton(
                        highlightedBorderColor: primaryColor,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .055,
                          width: MediaQuery.of(context).size.width * .65,
                          child: Center(
                              child: Text("${orientationlist[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: orientationlist[index]["ontap"]
                                          ? primaryColor
                                          : secondryColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: orientationlist[index]["ontap"]
                                ? primaryColor
                                : secondryColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
                          setState(() {
                            if (selected.length < 3) {
                              orientationlist[index]["ontap"] =
                                  !orientationlist[index]["ontap"];
                              if (orientationlist[index]["ontap"]) {
                                selected.add(orientationlist[index]["name"]);
                                print(orientationlist[index]["name"]);
                                print(selected);
                              } else {
                                selected.remove(orientationlist[index]["name"]);
                                print(selected);
                              }
                            } else {
                              if (orientationlist[index]["ontap"]) {
                                orientationlist[index]["ontap"] =
                                    !orientationlist[index]["ontap"];
                                selected.remove(orientationlist[index]["name"]);
                              } else {
                                snackbar("select upto 3");
                              }
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Checkbox(
                      activeColor: primaryColor,
                      value: select,
                      onChanged: (bool newValue) {
                        setState(() {
                          select = newValue;
                        });
                      },
                    ),
                    title: Text("Show my orientation on my profile"),
                  ),
                  selected.length > 0
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            primaryColor.withOpacity(.5),
                                            primaryColor.withOpacity(.8),
                                            primaryColor,
                                            primaryColor
                                          ])),
                                  height:
                                      MediaQuery.of(context).size.height * .065,
                                  width:
                                      MediaQuery.of(context).size.width * .75,
                                  child: Center(
                                      child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowGender()));
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * .065,
                                  width:
                                      MediaQuery.of(context).size.width * .75,
                                  child: Center(
                                      child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: secondryColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                              onTap: () {
                                snackbar("Please select one");
                              },
                            ),
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
