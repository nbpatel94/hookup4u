import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/Screens/Profile/settings.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/Screens/match/my_matches.dart';
import 'package:hookup4u/Screens/screen_social/home/tab3/message_user_list/chat_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab3/new_user_get/new_user_get_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';
import 'messages_page_viewmodel.dart';

class SocialMessagesScreen extends StatefulWidget {

  final bool isDrawerShow;
  const SocialMessagesScreen({Key key, this.isDrawerShow}) : super(key: key);

  @override
  SocialMessagesScreenState createState() => SocialMessagesScreenState();
}

class SocialMessagesScreenState extends State<SocialMessagesScreen> {

  SocialMessagesPageViewModel model;
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
                        child: appState.medialList!=null && appState.medialList.length != 0 ?
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
                        )
                         : Image.asset(
                          'asset/Icon/placeholder.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(appState.currentUserData?.data?.displayName ?? "",style: TextStyle(fontSize: 28,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w100,color: ColorRes.textColor)),

                      SizedBox(height: 2),
                      GestureDetector(
                          onTap: () {

                               // Navigator.pop(context);

                            // if(kIsWeb == false) {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));

                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfile()));
                            // } else {
                            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                            // }
                          },
                          child: Text("EDIT PROFILE",style: TextStyle(fontSize: 12,fontFamily: 'NeueFrutigerWorld',color: Colors.white,fontWeight: FontWeight.w700)))
                    ],
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
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
                              fontFamily: 'NeueFrutigerWorld',
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
                              fontFamily: 'NeueFrutigerWorld',
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
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = SocialMessagesPageViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
        title: Container(
          // margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/6),
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 6.0),
            alignment:Alignment.center,child: Text("Messages",style: TextStyle(fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w700))),
        backgroundColor: ColorRes.darkButton,
        centerTitle: true,
        leading: widget.isDrawerShow ? GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Icon(Icons.menu)) : Container(),
        actions: [
          Padding (
            padding: EdgeInsets.only(right: 10),
            child: InkWell (
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewUserListPage(mapData: model.listMapData)));
              },
              child: Icon(Icons.supervised_user_circle, color: ColorRes.white, size: 25),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Lottie.asset('asset/Icon/main_loader.json',
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2),
        ),
      ) :
      // model.matchList.isNotEmpty ?

      model?.threadDataModel?.data != null && model.threadDataModel.data.isNotEmpty ?

      SingleChildScrollView (
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container (
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration (
                color: ColorRes.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView.builder (
                physics: NeverScrollableScrollPhysics(),
                // itemCount: model.matchList.length,
                itemCount: model.threadDataModel.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column (
                    children: [
                      index == 0 ? SizedBox(height: 20) :
                      Divider (
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey,
                      ),
                      InkWell (
                        onTap: () async {

                        /*  var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SocialChatScreen(
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
                          );*/

                          var res = await Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (_) => SocialChatScreen (

                                  threadAllData: model.threadDataModel.data[index],

                             /*   sender: model.threadDataModel.data[index].lastMessage.senderId != appState.id.toString() ?
                                model.matchList[index].senderMeta :
                                model.matchList[index].targetMeta,
                                userId: model.matchList[index].senderId != appState.id.toString() ?
                                model.matchList[index].senderId :
                                model.matchList[index].taregtId,
                                threadId: model.matchList[index].threadId,
                                matchId: model.matchList[index].matchId,*/
                              ),
                            ),
                          );
                          if(res=='Yes') {
                            setState(() {
                              isLoading = true;
                            });
                            // model.getMyMatch();
                          }
                        },

                        child: Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row (
                                children: <Widget> [
                                  Stack (
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(60),
                                                  child: model.threadDataModel.data[index].recipientData.thumb.isNotEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: model.threadDataModel.data[index].recipientData.thumb,
                                                          // imageUrl:  model.tempList[index].recipients["${model.friendIdList[index]}"].userAvatars.thumb,
                                                          placeholder: (context, url) =>
                                                                  Image.asset(
                                                                    'asset/Icon/placeholder.png',
                                                                    height: 60,
                                                                    width: 60,
                                                                    fit: BoxFit.cover),
                                                          height: 60,
                                                          width: 60,
                                                          fit: BoxFit.cover)
                                                      : Image.asset('asset/Icon/placeholder.png',
                                                          height: 60,
                                                          width: 60,
                                                          fit: BoxFit.cover),
                                                ),
                                                // ClipRRect (
                                      //   borderRadius: BorderRadius.circular(80),
                                      //   child: model.matchList[index].senderId != appState.id.toString() ?
                                      //   model.matchList[index].senderMeta.media.isNotEmpty ?
                                      //   // child: model.friendIdList[index] != appState.id.toString() ?
                                      //   //        model.tempList[index].recipients["${model.friendIdList[index]}"].userAvatars.thumb.isNotEmpty ?
                                      //   CachedNetworkImage (
                                      //     imageUrl:  model.matchList[index].senderMeta.media[0],
                                      //     // imageUrl:  model.tempList[index].recipients["${model.friendIdList[index]}"].userAvatars.thumb,
                                      //     placeholder: (context, url) => Image.asset (
                                      //         'asset/Icon/placeholder.png',
                                      //          height: 60,
                                      //          width: 60,
                                      //      fit: BoxFit.cover,
                                      //     ),
                                      //     height: 60,
                                      //     width: 60,
                                      //     fit: BoxFit.cover
                                      //   ) : Image.asset(
                                      //     'asset/Icon/placeholder.png',
                                      //     height: 60,
                                      //     width: 60,
                                      //     fit: BoxFit.cover,
                                      //   ) :
                                      //   model.matchList[index].targetMeta.media.isNotEmpty ?
                                      //   CachedNetworkImage (
                                      //       imageUrl:  model.matchList[index].targetMeta.media[0],
                                      //       placeholder: (context, url) => Image.asset(
                                      //         'asset/Icon/placeholder.png',
                                      //         height: 60,
                                      //         width: 60,
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //       height: 60,
                                      //       width: 60,
                                      //       fit: BoxFit.cover
                                      //   ) : Image.asset (
                                      //     'asset/Icon/placeholder.png',
                                      //     height: 60,
                                      //     width: 60,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.green,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                                        child: Text("ONLINE",style: TextStyle(color: ColorRes.white,fontSize: 10,fontWeight: FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text( model.threadDataModel?.data[index]?.recipientData?.userName ?? "Empty",
                                            // model.matchList[index].senderId != appState.id.toString() ?
                                            // model.matchList[index].senderMeta.name :
                                            // model.matchList[index].targetMeta.name,
                                            style: TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 18,
                                              fontFamily: 'NeueFrutigerWorld',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.0),
                                      model.threadDataModel?.data[index]?.lastMessage?.message != null ? Container (
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          model.threadDataModel?.data[index]?.lastMessage?.message ?? "last message",
                                          // "${model.matchList[index].lastMessage}",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ) : Container(),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '${DateTime.now().hour}:${DateTime.now().minute}',
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
      style: TextStyle(color: ColorRes.textColor, fontSize: 16),
    ),),
      drawer: drawerWidget,
    );
  }
}
