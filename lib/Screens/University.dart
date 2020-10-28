import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'AllowLocation.dart';

class University extends StatefulWidget {
  @override
  _UniversityState createState() => _UniversityState();
}

String university = '';

class _UniversityState extends State<University> {
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
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, right: 40),
                      child: InkWell(
                        child: Text(
                          "Skip",
                          style: TextStyle(fontSize: 18, color: secondryColor),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllowLocation()));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    child: Text(
                      "My\nuniversity is",
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.only(left: 50, top: 120),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: 23),
                    decoration: InputDecoration(
                      hintText: "Enter your university name",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      helperText: "This is how it will appear in App.",
                      helperStyle:
                          TextStyle(color: secondryColor, fontSize: 15),
                    ),
                    onChanged: (value) {
                      setState(() {
                        university = value;
                      });
                    },
                  ),
                ),
              ),
              university.length > 0
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
                                    builder: (context) => AllowLocation()));
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
                          onTap: () {},
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
