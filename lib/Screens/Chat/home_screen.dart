import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';

import 'Matches.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorRes.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: chats.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Message chat = chats[index];
                  return Column(
                    children: [
                      index ==0 ? SizedBox(height: 20,): Divider(
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              sender: chat.sender,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      CircleAvatar(
                                        radius: 32.0,
                                        backgroundColor: secondryColor,
                                        backgroundImage: AssetImage(chat.sender.imageUrl[0]),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.green,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                                        child: Text("ONLINE",style: TextStyle(color: ColorRes.white,fontSize: 10,fontWeight: FontWeight.w600),),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            chat.sender.name,
                                            style: TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          chat.unread
                                              ? Container(
                                            // width: 40.0,
                                            // height: 20.0,
                                            padding: EdgeInsets.symmetric(horizontal: 7),
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '7',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                              : Text(''),
                                        ],
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          chat.text,
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                chat.time,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}
