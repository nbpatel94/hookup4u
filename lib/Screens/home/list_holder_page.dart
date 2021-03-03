import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/Chat/messages_page.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/Screens/Profile/settings.dart';
import 'package:hookup4u/Screens/cardpage/card_pictures.dart';
import 'package:hookup4u/Screens/match/my_matches.dart';
import 'package:hookup4u/Screens/screen_social/main_screen.dart';
import 'package:hookup4u/Screens/screen_social/setting_view/notification_onoff/notification_onoff_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/web_view/edit_profile_view/edit_profile_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

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
                    Container(
                      height: 205,
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: appState.medialList!=null &&  appState.medialList.isNotEmpty?
                            CachedNetworkImage(
                                imageUrl: appState.medialList[0].sourceUrl,
                                placeholder: (context, url) => Image.asset(
                                  'asset/Icon/placeholder.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover
                            ) : Image.asset(
                              'asset/Icon/placeholder.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(appState.currentUserData.data.displayName,style: TextStyle(fontSize: 28,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w100,color: ColorRes.textColor)),
                          SizedBox(height: 2,),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));

                                /*  if(kIsWeb == false) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfile()));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                }*/
                                // await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                                // setState(() {});
                              },
                              //uses
                              child: Text("EDIT PROFILE",style: TextStyle(fontSize: 12,fontFamily: 'NeueFrutigerWorld',color: Colors.white,fontWeight: FontWeight.w700)))
                        ],
                      ),
                    ),
                    SizedBox(height: 15), //70
                    Container(
                      height: MediaQuery.of(context).size.height - 300,
                      padding: EdgeInsets.only(bottom: 65),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MessagesScreen(isDrawerShow: true)));
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
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
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
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('/Pages', arguments: 4);
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
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationOnOFFPage()));
                              },
                              leading: Icon(
                                Icons.star,
                                color: ColorRes.textColor,
                                size: 25,
                              ),
                              title: Text(
                                'Notification',
                                style: TextStyle(
                                    color: ColorRes.textColor,
                                    fontSize: 18,
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
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
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SocialMainPage()));
                              },
                              leading: Icon(
                                Icons.home,
                                color: ColorRes.textColor,
                                size: 25,
                              ),
                              title: Text(
                                'Social Home',
                                style: TextStyle(
                                    color: ColorRes.textColor,
                                    fontSize: 18,
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Positioned(
                //   top: 30,
                //   right: 15,
                //   child: GestureDetector(
                //     onTap: (){
                //       Navigator.pop(context);
                //     },
                //     child: Icon(Icons.arrow_back,size: 30,color: ColorRes.textColor,),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(color: ColorRes.darkButton,height: 2,thickness: 2,),
                    Image.asset(
                      'asset/Icon/placeholder.png',
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
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
                          builder: (context) => MessagesScreen(isDrawerShow: true)));
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
