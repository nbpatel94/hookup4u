import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/Screens/cardpage/card_picture_view_Model.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/util/color.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();

List<ActivityModel> list2;

class CardPictures extends StatefulWidget {
  @override
  CardPicturesState createState() => CardPicturesState();
}

class CardPicturesState extends State<CardPictures>
    with AutomaticKeepAliveClientMixin<CardPictures> {
  CardPictureViewModel model;
  bool onEnd = false;
  bool isLoading = true;

  bool get wantKeepAlive => true;

  int currentPosition;

  @override
  Widget build(BuildContext context) {
    model ?? (model = CardPictureViewModel(this));

    super.build(context);
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      body: isLoading ? Center(child: Padding(
        padding: const EdgeInsets.only(bottom:50),
        child: Lottie.asset('asset/Icon/main_loader.json',height: MediaQuery.of(context).size.width/2,width: MediaQuery.of(context).size.width/2),
      ),): Container(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            onEnd
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onLongPress: (){
                            setState(() {
                              onEnd = false;
                            });
                            model.getUsers();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                'asset/Icon/placeholder.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,),
                          ),
                        ),
                        Text(
                          "There's no one new around you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorRes.textColor,
                              decoration: TextDecoration.none,
                              fontFamily: 'NeueFrutigerWorld',
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: SwipeStack(
                      key: swipeKey,
                      children: model.list.map((userModel) {
                        return SwiperItem(builder:
                            (SwiperPosition position, double progress) {
                          return Material(
                              elevation: 5,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    child: Swiper(
                                      customLayoutOption: CustomLayoutOption(
                                        startIndex: 0,
                                      ),
                                      key: UniqueKey(),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index2) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height / 2,
                                              width: MediaQuery.of(context).size.width,
                                              child: userModel.media!=null &&  userModel.media.isNotEmpty?
                                              CachedNetworkImage(
                                                imageUrl: userModel.media[index2],
                                                  placeholder: (context, url) => Image.asset(
                                                    'asset/Icon/icon_dark.png',
                                                    height: MediaQuery.of(context).size.height / 2,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  fit: BoxFit.cover
                                              )
                                               : Image.asset(
                                                'asset/Icon/icon_dark.png',
                                                height: MediaQuery.of(context).size.height / 2,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            // Align(
                                            //   alignment : Alignment.centerRight,
                                            //   child: GestureDetector(
                                            //     onTap :() {
                                            //
                                            //     },
                                            //     child: Container(
                                            //       width: 60,
                                            //       color: Colors.grey.withOpacity(0.5),),
                                            //   ),
                                            // ),
                                            // Align(
                                            //   alignment : Alignment.centerLeft,
                                            //   child: GestureDetector(
                                            //     child: Container(
                                            //       width: 60,
                                            //       color: Colors.grey.withOpacity(0.5),),
                                            //   ),
                                            // )
                                          ],
                                        );
                                      },
                                      itemCount: userModel.media!=null &&  userModel.media.isNotEmpty? userModel.media.length: 1,
                                      pagination: new SwiperPagination(
                                          alignment: Alignment.bottomCenter,
                                          builder: DotSwiperPaginationBuilder(
                                              activeSize: 13,
                                              color: ColorRes.secondaryColor,
                                              activeColor: ColorRes.primaryColor)),
                                      loop: false,
                                      control: new SwiperControl(
                                        color: ColorRes.primaryColor,
                                        disableColor: ColorRes.secondaryColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(48.0),
                                    child: position.toString() ==
                                            "SwiperPosition.Left"
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: Transform.rotate(
                                              angle: pi / 8,
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.red)),
                                                child: Center(
                                                  child: Text("NOPE",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 32)),
                                                ),
                                              ),
                                            ),
                                          )
                                        : position.toString() ==
                                                "SwiperPosition.Right"
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Transform.rotate(
                                                  angle: -pi / 8,
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .lightBlueAccent)),
                                                    child: Center(
                                                      child: Text("LIKE",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 32)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: ListTile(
                                            onTap: () => showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Info(userModel);
                                                }),
                                            title: Text(
                                              "${userModel.data.displayName}  ${ageCount(userModel.dateOfBirth.replaceAll('/', '-'))}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              "${userModel.livingIn}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ))),
                                  ),
                                ],
                              ));
                        });
                      }).toList(growable: true),
                      threshold: 30,
                      maxAngle: 100,
                      animationDuration: Duration(milliseconds: 600),
                      visibleCount: 2,
                      historyCount: 1,
                      stackFrom: StackFrom.Right,
                      translationInterval: 5,
                      scaleInterval: 0.08,
                      onEnd: () {
                        setState(() {
                          onEnd = true;
                        });
                        model.list.removeLast();
                      },
                      onSwipe: (int index, SwiperPosition position) async {
                        if(currentPosition!=index){
                          if (index + 1 < model.list.length) {
                            model.list.removeAt(index + 1);
                          }
                          if(position==SwiperPosition.Right){
                            print("----------");
                            print("Like Time-> ${DateTime.now().difference(appState.likeTime).inMinutes}");
                            if(appState.subscriptionDate!=null && DateTime.now().difference(appState.subscriptionDate).inDays>=30) {
                              appState.likeCount = 30;
                            }else{
                              if(DateTime.now().difference(appState.likeTime).inMinutes>=1 && appState.likeCount==0){
                                appState.likeCount = 2;
                              }
                            }
                            if (model.list.length > 0 && appState.likeCount!=0) {
                              print("Giving Like");
                              print(swipeKey.currentState.currentIndex);
                              print(list2[swipeKey.currentState.currentIndex].data.displayName);
                              appState.likeCount--;
                              appState.likeTime = DateTime.now();
                              await sharedPreferences.setString(Preferences.likeTime, DateTime.now().toString());
                              await sharedPreferences.setInt(Preferences.likeCount, appState.likeCount);

                              print("Superlike Count -> ${appState.superLikeCount} Superlike time -> ${appState.superLikeTime}");
                              print("Like Count -> ${appState.likeCount} Like time -> ${appState.likeTime}");

                              // model.queue.add(() => model.giveLike(list2[swipeKey.currentState.currentIndex].data.id));
                              swipeKey.currentState.swipeRight();
                            }else{
                              print("You are out of likes");
                            }
                            print("----------");
                          }else if(position==SwiperPosition.Left){
                            print(index);
                            print(list2[index].data.displayName);
                            model.queue.add(() => model.giveDislike(list2[index].data.id));
                          }
                        }
                      },
                      onRewind: (int index, SwiperPosition position) =>
                          debugPrint("onRewind $index $position"),
                    ),
                  ),
            !onEnd
                ? Padding(
                    padding: const EdgeInsets.all(25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async{
                              print("----------");
                              print("SuperLike Time-> ${DateTime.now().difference(appState.superLikeTime).inMinutes}");
                              if(DateTime.now().difference(appState.superLikeTime).inMinutes>=1440 && appState.superLikeCount==0){
                                if(appState.subscriptionDate!=null && DateTime.now().difference(appState.subscriptionDate).inDays>=30) {
                                  appState.superLikeCount = 5;
                                }else{
                                  appState.superLikeCount = 1;
                                }
                              }
                              if (model.list.length > 0 && appState.superLikeCount!=0) {
                                currentPosition = swipeKey.currentState.currentIndex;
                                print("Giving SuperLike");
                                print(swipeKey.currentState.currentIndex);
                                print(list2[swipeKey.currentState.currentIndex].data.displayName);
                                appState.superLikeCount--;
                                appState.superLikeTime = DateTime.now();
                                await sharedPreferences.setString(Preferences.superLikeTime, DateTime.now().toString());
                                await sharedPreferences.setInt(Preferences.superLikeCount, appState.superLikeCount);

                                print("Superlike Count -> ${appState.superLikeCount} Superlike time -> ${appState.superLikeTime}");
                                print("Like Count -> ${appState.likeCount} Like time -> ${appState.likeTime}");

                                model.queue.add(() => model.giveSuperLike(list2[swipeKey.currentState.currentIndex].data.id));
                                swipeKey.currentState.swipeRight();
                              }else{
                                print("You are out of supelikes");
                              }
                              print("----------");
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: ColorRes.superLike,
                              ),
                              padding: EdgeInsets.all(18),
                              child: Image.asset(
                                'asset/Icon/star.png',
                                fit: BoxFit.cover,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (model.list.length > 0) {
                                currentPosition = swipeKey.currentState.currentIndex;
                                print(list2[swipeKey.currentState.currentIndex].data.displayName);
                                model.queue.add(() => model.giveDislike(list2[swipeKey.currentState.currentIndex].data.id));
                                swipeKey.currentState.swipeLeft();
                              }
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: ColorRes.darkButton,
                              ),
                              padding: EdgeInsets.all(18),
                              child: Image.asset(
                                'asset/Icon/close.png',
                                fit: BoxFit.cover,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              print("----------");
                              print("Like Time-> ${DateTime.now().difference(appState.likeTime).inMinutes}");
                              if(appState.subscriptionDate!=null && DateTime.now().difference(appState.subscriptionDate).inDays>=30) {
                                  appState.likeCount = 30;
                              }else{
                                if(DateTime.now().difference(appState.likeTime).inMinutes>=1440 && appState.likeCount==0){
                                  appState.likeCount = 2;
                                }
                              }
                              if (model.list.length > 0 && appState.likeCount!=0) {
                                print("Giving Like");
                                print(swipeKey.currentState.currentIndex);
                                currentPosition = swipeKey.currentState.currentIndex;
                                print(list2[swipeKey.currentState.currentIndex].data.displayName);
                                appState.likeCount--;
                                appState.likeTime = DateTime.now();
                                await sharedPreferences.setString(Preferences.likeTime, DateTime.now().toString());
                                await sharedPreferences.setInt(Preferences.likeCount, appState.likeCount);

                                print("Superlike Count -> ${appState.superLikeCount} Superlike time -> ${appState.superLikeTime}");
                                print("Like Count -> ${appState.likeCount} Like time -> ${appState.likeTime}");

                                model.queue.add(() => model.giveLike(list2[swipeKey.currentState.currentIndex].data.id));
                                swipeKey.currentState.swipeRight();
                              }else{
                                print("You are out of likes");
                              }
                              print("----------");
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: ColorRes.redButton,
                              ),
                              padding: EdgeInsets.all(18),
                              child: Image.asset(
                                'asset/Icon/like.png',
                                fit: BoxFit.cover,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  int ageCount(String date){
    return DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(date)).inDays~/365;
  }
}
