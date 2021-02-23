import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/friends/friends_screen.dart';
import 'package:hookup4u/util/color.dart';

import 'notification_onoff/notification_onoff_screen.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  List<String> itemList = ["Push Notifications", "Language", "Linked Accounts", "Blocked Accounts", "Search History", "Reports a Problem"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("Settings", style: TextStyle(color: ColorRes.white, fontSize: 33))),
          Expanded(child: ListView.separated(
              itemCount: itemList.length,
              separatorBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Divider(height: 1, color: ColorRes.black));
              },
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                  if(index == 0) {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationOnOFFPage()));
                  } else if(index == 1) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsScreen()));
                  } else {

                  }
                },
                child: Container(
                  height: 80,
                  margin: EdgeInsets.only(right: 5, left: 25),
                  decoration: BoxDecoration(

                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text(itemList[index], style: TextStyle(color: ColorRes.white, fontSize: 20)),
                    Icon(Icons.chevron_right, color: ColorRes.white, size: 35)
                  ]),
                ),
              );
          })),
        ],
      ),


    );

  }
}
