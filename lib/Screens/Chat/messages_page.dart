import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/Screens/Chat/messages_page_viewmodel.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/Screens/Profile/settings.dart';
import 'package:hookup4u/Screens/match/my_matches.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';

class MessagesScreen extends StatefulWidget {
  @override
  MessagesScreenState createState() => MessagesScreenState();
}

class MessagesScreenState extends State<MessagesScreen> {

  MessagesPageViewModel model;
  bool isLoading = true;

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
                        child: appState.medialList!=null ? Image.network(
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
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
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
                          Navigator.pushReplacement(
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
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyMatchesPage()));
                          // Navigator.of(context).pushNamed('/Pages', arguments: 3);
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
                          Navigator.pushReplacement(
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    model ?? (model = MessagesPageViewModel(this));
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Container(
          // margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/6),
          margin: EdgeInsets.only(right: 40),
            alignment:Alignment.center,child: Text("Messages",)),
        backgroundColor: ColorRes.darkButton,
        leading: GestureDetector(
            onTap: (){
              _scaffoldKey.currentState.openDrawer();
            },
            child: Icon(Icons.menu)),
      ),
      body: isLoading
          ? Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Lottie.asset('asset/Icon/main_loader.json',
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2),
        ),
      )
          : model.matchList.isNotEmpty ?
      SingleChildScrollView(
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
                itemCount: model.matchList.length,
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
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              sender: model.matchList[index].senderId != appState.id.toString() ?
                              model.matchList[index].senderMeta :
                              model.matchList[index].targetMeta,
                              userId: model.matchList[index].senderId != appState.id.toString() ?
                              model.matchList[index].senderId :
                              model.matchList[index].taregtId,
                              threadId: model.matchList[index].threadId,
                              matchId: model.matchList[index].matchId,
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: model.matchList[index].senderId != appState.id.toString() ?
                                        model.matchList[index].senderMeta.media.isNotEmpty
                                            ?
                                        Image.network(
                                          model.matchList[index].senderMeta.media[0],
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ) : Image.asset(
                                          'asset/userPictures/otherUsers/bunny1.jpeg',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        )
                                            :
                                        model.matchList[index].targetMeta.media.isNotEmpty
                                            ?
                                        Image.network(
                                          model.matchList[index].targetMeta.media[0],
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ) : Image.asset(
                                          'asset/userPictures/otherUsers/bunny1.jpeg',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
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
                                            model.matchList[index].senderId != appState.id.toString() ?
                                            model.matchList[index].senderMeta.name :
                                            model.matchList[index].targetMeta.name,
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
      ) : Center(
      child: Text(
      "No Matches",
      style: TextStyle(color: secondryColor, fontSize: 16),
    ),),
      drawer: drawerWidget,
    );
  }
}
