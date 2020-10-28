import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/util/color.dart';

class AllowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundColor: secondryColor.withOpacity(.2),
                    radius: 110,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(40),
                    child: RichText(
                      text: TextSpan(
                        text: "Enable location",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        children: [
                          TextSpan(
                              text: """\nYou'll need to enable your
location
in order to use application.
                              """,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: secondryColor,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 18)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.arrow_drop_down),
                      label: Text("Show more")),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
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
                        "ALLOW LOCATION",
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ))),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => ListHolderPage()),
                        ModalRoute.withName('/'));
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
