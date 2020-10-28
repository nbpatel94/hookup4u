import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/SexualOrientation.dart';
import 'package:hookup4u/util/color.dart';

bool man = false;
bool woman = false;
bool other = false;
bool select = false;

class Gender extends StatefulWidget {
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  snackbar(String text) {
    final snackBar = SnackBar(
      content: Text('$text '),
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
      body: Stack(
        children: <Widget>[
          Padding(
            child: Text(
              "I am a",
              style: TextStyle(fontSize: 40),
            ),
            padding: EdgeInsets.only(left: 50, top: 120),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  highlightedBorderColor: primaryColor,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width * .75,
                    child: Center(
                        child: Text("MAN",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    man ? primaryColor : secondryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                  borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: man ? primaryColor : secondryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {
                    setState(() {
                      woman = false;
                      man = true;
                      other = false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlineButton(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text("WOMAN",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: woman
                                      ? primaryColor
                                      : secondryColor,
                                  fontWeight: FontWeight.bold))),
                    ),
                    borderSide: BorderSide(
                      color: woman ? primaryColor : secondryColor,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () {
                      setState(() {
                        woman = true;
                        man = false;
                        other = false;
                      });
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => OTP()));
                    },
                  ),
                ),
                OutlineButton(
                  focusColor: primaryColor,
                  highlightedBorderColor: primaryColor,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width * .75,
                    child: Center(
                        child: Text("OTHER",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    other ? primaryColor : secondryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                  borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: other ? primaryColor : secondryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {
                    setState(() {
                      woman = false;
                      man = false;
                      other = true;
                    });
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (context) => OTP()));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0, left: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Checkbox(
                  activeColor: primaryColor,
                  value: select,
                  onChanged: (bool newValue) {
                    setState(() {
                      select = newValue;
                    });
                  },
                ),
                title: Text("Show my gender on my profile"),
              ),
            ),
          ),
          man || woman || other
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
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .75,
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
                                builder: (context) => SexualOrientation()));
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
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .75,
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
    );
  }
}
