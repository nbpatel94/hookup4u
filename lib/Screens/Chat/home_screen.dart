import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Chat/recent_chats.dart';
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
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.search, size: 30.0),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: TextField(
          cursorColor: Colors.white,
          autofocus: false,
          decoration: InputDecoration(
              //focusColor: Colors.white,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintText: "Search matches",
              hintStyle: TextStyle(
                color: Colors.white,
              )),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            iconSize: 20.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Matches(),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
