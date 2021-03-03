import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_onoff_viewmodel.dart';

class NotificationOnOFFPage extends StatefulWidget {
  @override
  NotificationOnOFFPageState createState() => NotificationOnOFFPageState();
}

class NotificationOnOFFPageState extends State<NotificationOnOFFPage> {

  bool status = false;
  SharedPreferences prefs;
  String getToken = "";


  NotificationOnOffViewModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = NotificationOnOffViewModel(this));
    sharedPref();
  }

  sharedPref() async {
     prefs = await SharedPreferences.getInstance();
     // bool isKey = prefs.containsKey("deviceToken");
     // if(isKey){
     //   getToken = prefs.getString("deviceToken");
     // }
       getToken = appState.userDetailsModel.meta.deviceToken;
     if(getToken != null && getToken.isNotEmpty) {
       status = true;
     } else {
       status = false;
     }
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorRes.tabBg,
                  shape: BoxShape.circle
              ),
              child: Container(
                padding: EdgeInsets.all(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorRes.divided,
                    shape: BoxShape.circle
                ),
                child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage("asset/Icon/bell.png")),
              ),
            ),
            // Icon(Icons.notifications, color: ColorRes.white, size: 100),
            SizedBox(height: 30),
            Text("Turn on \n Notifications", style: TextStyle(color: ColorRes.white, fontSize: 30), textAlign: TextAlign.center),
            SizedBox(height: 25),
            Text("Enable push notifications to let send you \n personal news and updates", style: TextStyle(color: ColorRes.white, fontSize: 18), textAlign: TextAlign.center),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(spreadRadius: 2, color: ColorRes.black, blurRadius: 2)]
              ),
              height: 70,
              margin: EdgeInsets.only(left: 25, right: 25),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Turn on notifications", style: TextStyle(color: ColorRes.black, fontSize: 15), textAlign: TextAlign.center),
                  CupertinoSwitch(
                    // activeColor: Colors.pinkAccent,
                    value: status,
                    onChanged: (value) {
                      print("VALUE : $value");

                      model.notificationTokenSend();

                      setState(() {
                        status = value;
                      });
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
