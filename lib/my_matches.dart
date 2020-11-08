import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';

import 'Screens/match/my_match_viewmodel.dart';

class MyMatchesPage extends StatefulWidget {
  @override
  MyMatchesPageState createState() => MyMatchesPageState();
}

class MyMatchesPageState extends State<MyMatchesPage> {
  bool isLoading = true;

  MyMatchViewModel model;

  @override
  Widget build(BuildContext context) {
    model ?? (model = MyMatchViewModel(this));

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: isLoading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Lottie.asset('asset/Icon/main_loader.json',
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2),
                ),
              )
            : model.matchList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.matchList.length,
                    itemBuilder: (BuildContext context, index) {
                      return int.parse(model.matchList[index].senderId) == appState.id && model.matchList[index].mutualMatch=='true'
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  margin: EdgeInsets.only(top: 20),
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'asset/Icon/like.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "It's a match!",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 3),
                                        child: Text(
                                          "You and ${model.matchList[index].targetMeta.name} liked each other,\nYou can send him a message",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: model.matchList[index].targetMeta.media.isNotEmpty ? Image.network(
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
                                    // SizedBox(
                                    //   width: 3,
                                    // ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: appState.medialList.isNotEmpty ? Image.network(
                                        appState.medialList[0].sourceUrl,
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
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * .055,
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: ColorRes.redButton,
                                    ),
                                    child: Center(
                                        child:Text("SEND A MESSAGE",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold))),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * .055,
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: ColorRes.darkButton,
                                    ),
                                    child: Center(
                                        child: Text("KEEP BROWSING",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold))),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white),
                                        width: MediaQuery.of(context).size.width * 0.80,
                                        margin: EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                              'asset/Icon/like.png',
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30,vertical: 3),
                                              child: Text(
                                                "${model.matchList[index].senderMeta.name} liked you!",
                                                style: TextStyle(fontSize: 24),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 3),
                                              child: Text(
                                                "${model.matchList[index].senderMeta.name} send you a like",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(80),
                                            child: model.matchList[index].targetMeta.media.isNotEmpty ? Image.network(
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
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await model.sendMatch(index,model.matchList[index].matchId);
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * .055,
                                            width: MediaQuery.of(context).size.width / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: ColorRes.redButton,
                                            ),
                                            child: Center(
                                                child:Text("MATCH",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .bold))),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await model.deleteMatch(index,model.matchList[index].matchId);
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * .055,
                                            width: MediaQuery.of(context).size.width / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: ColorRes.darkButton,
                                            ),
                                            child: Center(
                                                child: Text("REJECT",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                    })
                : Center(
                    child: Text(
                    "No Notification",
                    style: TextStyle(color: secondryColor, fontSize: 16),
                  )));
  }
}
