import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';
import 'my_match_viewmodel.dart';

class MyMatchesPage extends StatefulWidget {
  @override
  MyMatchesPageState createState() => MyMatchesPageState();
}

class MyMatchesPageState extends State<MyMatchesPage> {
  bool isLoading = true;

  MyMatchViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = MyMatchViewModel(this));

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'My Matches',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: ColorRes.primaryColor,
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
                      return model.matchList[index].mutualMatch=='true'
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
                                        style: TextStyle(fontSize: 24,fontFamily: 'NeueFrutigerWorld',),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 3),
                                        child: Text(
                                          "You and ${model.matchList[index].senderId != appState.id.toString() ? model.matchList[index].senderMeta.name : model.matchList[index].targetMeta.name} liked each other,\nYou can send a message",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'NeueFrutigerWorld',fontSize: 16,height: 1.1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () => showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return InfoMatch(model.matchList[index]);
                                          }),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: model.matchList[index].senderId != appState.id.toString() ?
                                        model.matchList[index].senderMeta.media.isNotEmpty
                                            ?
                                        CachedNetworkImage(
                                          imageUrl:  model.matchList[index].senderMeta.media[0],
                                          placeholder: (context, url) => Image.asset(
                                            'asset/Icon/placeholder.png',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover
                                        ) : Image.asset(
                                          'asset/Icon/placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        )
                                            :
                                        model.matchList[index].targetMeta.media.isNotEmpty
                                            ?
                                        CachedNetworkImage(
                                            imageUrl:  model.matchList[index].targetMeta.media[0],
                                            placeholder: (context, url) => Image.asset(
                                              'asset/Icon/placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover
                                        ) : Image.asset(
                                          'asset/Icon/placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: appState.medialList.isNotEmpty ?
                                    CachedNetworkImage(
                                      imageUrl:  appState.medialList[0].sourceUrl,
                                      placeholder: (context, url) => Image.asset(
                                        'asset/Icon/placeholder.png',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover
                                    ) : Image.asset(
                                        'asset/Icon/placeholder.png',
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
                                  InkWell(
                                    onTap: () async {
                                      var res = await Navigator.push(
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
                                      );

                                      if(res=='Yes'){
                                        setState(() {
                                          isLoading = true;
                                        });
                                        model.getMyMatch();
                                      }
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
                                          child:Text("SEND A MESSAGE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'NeueFrutigerWorld',
                                                  fontWeight: FontWeight
                                                      .w700))),
                                    ),
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
                                                fontFamily: 'NeueFrutigerWorld',
                                                fontWeight: FontWeight
                                                    .w700))),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                          : model.matchList[index].senderId != appState.id.toString() ?
                      Padding(
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
                                                "${model.matchList[index].senderId != appState.id.toString() ? model.matchList[index].senderMeta.name : model.matchList[index].targetMeta.name} liked you!",
                                                style: TextStyle(fontFamily: 'NeueFrutigerWorld',fontSize: 24),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 3),
                                              child: Text(
                                                "${model.matchList[index].senderId != appState.id.toString() ? model.matchList[index].senderMeta.name : model.matchList[index].targetMeta.name} send you a like",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontFamily: 'NeueFrutigerWorld',fontSize: 16,height: 1.1),
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
                                            child: model.matchList[index].senderId != appState.id.toString() ?
                                            model.matchList[index].senderMeta.media.isNotEmpty
                                                ?
                                            CachedNetworkImage(
                                                imageUrl:  model.matchList[index].senderMeta.media[0],
                                                placeholder: (context, url) => Image.asset(
                                                  'asset/Icon/placeholder.png',
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.cover
                                            ) : Image.asset(
                                              'asset/Icon/placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            )
                                                :
                                            model.matchList[index].targetMeta.media.isNotEmpty
                                                ?
                                            CachedNetworkImage(
                                                imageUrl:  model.matchList[index].targetMeta.media[0],
                                                placeholder: (context, url) => Image.asset(
                                                  'asset/Icon/placeholder.png',
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.cover
                                            ) : Image.asset(
                                              'asset/Icon/placeholder.png',
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
                                                            fontFamily: 'NeueFrutigerWorld',
                                                            fontWeight: FontWeight
                                                                .w700))),
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
                                                        fontFamily: 'NeueFrutigerWorld',
                                                        fontWeight: FontWeight
                                                            .w700))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ) : Center(
                          child: Text(
                            "No Matches",
                            style: TextStyle(color: ColorRes.secondaryColor, fontSize: 16),
                          ));
                    })
                : Center(
                    child: Text(
                    "No Matches",
                    style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.secondaryColor, fontSize: 16),
                  )));
  }
}
