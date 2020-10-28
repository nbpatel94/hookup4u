import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:hookup4u/util/color.dart';
import 'cardpage/card_pictures.dart';

class Info extends StatelessWidget {
  final User user;
  Info(this.user);

  @override
  Widget build(BuildContext context) {
    bool isMe = user.id == currentUser.id;
    bool isMatched = false;
    //matches.any((value) => value.id == user.id);
    print(isMatched);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      key: UniqueKey(),
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index2) {
                        return user.imageUrl.length != null
                            ? Image.asset(
                                user.imageUrl[index2],
                                fit: BoxFit.cover,
                              )
                            : Container();
                      },
                      itemCount: user.imageUrl.length,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 13,
                              color: secondryColor,
                              activeColor: primaryColor)),
                      control: new SwiperControl(
                        color: primaryColor,
                        disableColor: secondryColor,
                      ),
                      loop: false,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            subtitle: Text("${user.address}"),
                            title: Text(
                              "${user.name}, ${user.age}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: primaryColor,
                                )),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.book, color: primaryColor),
                            title: Text(
                              "Student",
                              style: TextStyle(
                                  color: secondryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.grade, color: primaryColor),
                            title: Text(
                              "University of New York",
                              style: TextStyle(
                                  color: secondryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(
                              Icons.location_on,
                              color: primaryColor,
                            ),
                            title: Text(
                              "Less than 1 KM away",
                              style: TextStyle(
                                  color: secondryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            !isMe && !isMatched
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FloatingActionButton(
                              heroTag: UniqueKey(),
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                swipeKey.currentState.swipeLeft();
                              }),
                          FloatingActionButton(
                              heroTag: UniqueKey(),
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.lightBlueAccent,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                swipeKey.currentState.swipeRight();
                              }),
                        ],
                      ),
                    ),
                  )
                : !isMatched
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: primaryColor,
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile())))),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message,
                                  color: primaryColor,
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatScreen(sender: user))))),
                      )
          ],
        ),
      ),
    );
  }
}
