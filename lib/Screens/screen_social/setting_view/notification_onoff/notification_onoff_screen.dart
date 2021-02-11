import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';

class NotificationOnOFFPage extends StatefulWidget {
  @override
  _NotificationOnOFFPageState createState() => _NotificationOnOFFPageState();
}

class _NotificationOnOFFPageState extends State<NotificationOnOFFPage> {

  bool status = false;


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
