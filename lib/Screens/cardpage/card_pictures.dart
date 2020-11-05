import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/Screens/cardpage/card_picture_view_Model.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';
import 'package:swipe_stack/swipe_stack.dart';

GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();

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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: secondryColor,
                            radius: 40,
                          ),
                        ),
                        Text(
                          "There's no one new around you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: secondryColor,
                              decoration: TextDecoration.none,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: SwipeStack(
                      key: swipeKey,
                      children: model.list.reversed.map((index) {
                        // User user;
                        return SwiperItem(builder:
                            (SwiperPosition position, double progress) {
                          return Material(
                              elevation: 5,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Swiper(
                                      customLayoutOption: CustomLayoutOption(
                                        startIndex: 0,
                                      ),
                                      key: UniqueKey(),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            'https://freepngimg.com/thumb/light/2-2-light-free-download-png.png',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                      itemCount: 1,
                                      pagination: new SwiperPagination(
                                          alignment: Alignment.bottomCenter,
                                          builder: DotSwiperPaginationBuilder(
                                              activeSize: 13,
                                              color: secondryColor,
                                              activeColor: primaryColor)),
                                      loop: false,
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
                                  // Padding(
                                  //   padding: const EdgeInsets.only(bottom: 10),
                                  //   child: Align(
                                  //       alignment: Alignment.bottomLeft,
                                  //       child: ListTile(
                                  //           onTap: () => showDialog(
                                  //               barrierDismissible: false,
                                  //               context: context,
                                  //               builder: (context) {
                                  //                 return Info(index);
                                  //               }),
                                  //           title: Text(
                                  //             "${index.name}  ${index.age}",
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 25,
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //           subtitle: Text(
                                  //             "${index.address}",
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 20,
                                  //             ),
                                  //           ))),
                                  // ),
                                ],
                              ));
                        });
                      }).toList(growable: true),
                      threshold: 30,
                      maxAngle: 100,
                      //animationDuration: Duration(milliseconds: 400),
                      visibleCount: 3,
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
                      onSwipe: (int index, SwiperPosition position) {
                        if (index + 1 < model.list.length) {
                          model.list.removeAt(index + 1);
                        }

                        debugPrint("onSwipe $index $position");
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
                            onTap: () {
                              if (model.list.length > 0) {
                                swipeKey.currentState.swipeLeft();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.asset(
                                'asset/userPictures/otherUsers/bunny1.jpeg',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (model.list.length > 0) {
                                swipeKey.currentState.swipeRight();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.asset(
                                'asset/userPictures/otherUsers/bunny1.jpeg',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
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
}
