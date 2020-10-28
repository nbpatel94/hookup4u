import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/Profile/profile.dart';
import 'package:hookup4u/Screens/notifications.dart';
import '../Chat/home_screen.dart';
import '../cardpage/card_pictures.dart';
import 'package:hookup4u/util/color.dart';

class ListHolderPage extends StatefulWidget {
  @override
  ListHolderPageState createState() => ListHolderPageState();
}

class ListHolderPageState extends State<ListHolderPage> {

  bool isLoading = false;

  DateTime currentBackPressTime;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  showSnack(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                ),
              )
            : DefaultTabController(
                length: 4,
                initialIndex: 1,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: primaryColor,
                      automaticallyImplyLeading: false,
                      title: TabBar(
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.whatshot,
                              ),

                              // child: Switch(
                              //     materialTapTargetSize: MaterialTapTargetSize.padded,
                              //     activeColor: primaryColor,
                              //     value: false,
                              //     onChanged: (value) {
                              //       value = !value;
                              //     }),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.notifications,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.message,
                              ),
                            )
                          ]),
                    ),
                    body: TabBarView(
                      children: [
                        Center(child: Profile()),
                        Center(child: CardPictures()),
                        Center(child: Notifications()),
                        Center(child: HomeScreen()),
                      ],
                      physics: NeverScrollableScrollPhysics(),
                    )),
              ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showSnack('Tap again for exit');
      return Future.value(false);
    }
    SystemNavigator.pop(animated: true);
    return Future.value(true);
  }
}
