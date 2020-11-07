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
        backgroundColor: ColorRes.primaryColor,
        bottomNavigationBar: Container(
          child: InkWell(
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                    color: ColorRes.redButton),
                height: MediaQuery.of(context).size.height * .065,
                margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
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
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "iHeartMuslims",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 35,
                          color: ColorRes.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Welcome to IHeartMuslims.\nPlease follow these House Rules.",
                      style: TextStyle(
                          fontSize: 18, color: ColorRes.white,fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Be yourself.",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: ColorRes.white),
                    ),
                    subtitle: Text(
                      "Make sure your photos, age, and bio are true to who you are.",
                      style: TextStyle(
                        fontSize: 19, color: ColorRes.textColor
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Play it cool.",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: ColorRes.white),
                    ),
                    subtitle: Text(
                      "Respect other and treat them as you would like to be treated",
                      style: TextStyle(
                        fontSize: 17,
                          color: ColorRes.textColor
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Stay safe.",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: ColorRes.white),
                    ),
                    subtitle: Text(
                      "Don't be too quick to give out personal information.",
                      style: TextStyle(
                        fontSize: 17, color: ColorRes.textColor
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Be proactive.",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: ColorRes.white),
                    ),
                    subtitle: Text(
                      "Always report bad behavior.",
                      style: TextStyle(
                        fontSize: 17, color: ColorRes.textColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
