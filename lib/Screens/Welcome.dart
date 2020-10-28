import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Gender.dart';
import 'package:hookup4u/util/color.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        "hookup4u",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      ListTile(
                        title: Text(
                          "Welcome to hookup4u.\nPlease follow these House Rules.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Be yourself.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Make sure your photos, age, and bio are true to who you are.",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Play it cool.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Respect other and treat them as you would like to be treated",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Stay safe.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Don't be too quick to give out personal information.",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Be proactive.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Always report bad behavior.",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 50),
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
                          "GOT IT",
                          style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ))),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Gender()));
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
