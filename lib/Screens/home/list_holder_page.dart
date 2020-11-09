import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/Chat/messages_page.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/Screens/Profile/settings.dart';
import 'package:hookup4u/app.dart';
import 'file:///E:/Priyesh/hookup4u/lib/Screens/match/my_matches.dart';
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

  get drawerWidget => SafeArea(
        child: Drawer(
          child: Container(
            color: ColorRes.primaryColor,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: appState.medialList!=null &&  appState.medialList.isNotEmpty? Image.network(
                              appState.medialList[0].sourceUrl,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ) : Image.asset(
                              'asset/userPictures/otherUsers/bunny1.jpeg',
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(appState.currentUserData.data.displayName,style: TextStyle(fontSize: 28,color: ColorRes.textColor)),
                          SizedBox(height: 2,),
                          GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()));
                                setState(() {

                                });
                              },
                              child: Text("EDIT PROFILE",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/Pages', arguments: 2);
                            },
                            leading: Icon(
                              Icons.group_rounded,
                              color: ColorRes.textColor,
                              size: 25,
                            ),
                            title: Text(
                              'Browse',
                              style: TextStyle(
                                  color: ColorRes.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagesScreen()));
                            },
                            leading: Icon(
                              Icons.message,
                              color: ColorRes.textColor,
                              size: 25,
                            ),
                            title: Text(
                              'Message',
                              style: TextStyle(
                                  color: ColorRes.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMatchesPage()));
                            },
                            leading: Icon(
                              Icons.favorite_outlined,
                              color: ColorRes.textColor,
                              size: 25,
                            ),
                            title: Text(
                              'My Matches',
                              style: TextStyle(
                                  color: ColorRes.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                            },
                            leading: Icon(
                              Icons.star,
                              color: ColorRes.textColor,
                              size: 25,
                            ),
                            title: Text(
                              'Favorite',
                              style: TextStyle(
                                  color: ColorRes.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()));
                            },
                            leading: Icon(
                              Icons.settings,
                              color: ColorRes.textColor,
                              size: 25,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                  color: ColorRes.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 30,
                  right: 15,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 30,color: ColorRes.textColor,),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  showSnack(String text) {
    final snackBar = SnackBar(
      content: Text('$text ',style: TextStyle(color: ColorRes.white),textAlign: TextAlign.center,),
      backgroundColor: ColorRes.redButton,
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
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: (){
                _scaffoldKey.currentState.openDrawer();
              },
              child: Icon(Icons.menu)),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagesScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.message),
                )),
          ],
        ),
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                ),
              )
            : CardPictures(),
        drawer: drawerWidget,
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
