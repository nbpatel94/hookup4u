import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:intl/intl.dart';

class Info extends StatelessWidget {
  final ActivityModel user;

  Info(this.user);

  @override
  Widget build(BuildContext context) {
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
                        return user.media!=null &&  user.media.isNotEmpty?
                        CachedNetworkImage(
                            imageUrl: user.media[index2],
                            placeholder: (context, url) => Image.asset(
                              'asset/Icon/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover
                        )
                        : Image.asset(
                          'asset/Icon/placeholder.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: user.media.length,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 13,
                              color: ColorRes.secondaryColor,
                              activeColor: ColorRes.primaryColor)),
                      control: new SwiperControl(
                        color: ColorRes.primaryColor,
                        disableColor: ColorRes.secondaryColor,
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
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            subtitle: Text("${user.livingIn}\n\n${user.about}",style: TextStyle(fontFamily: 'NeueFrutigerWorld',),),
                            title: Text(
                              "${user.data.displayName}  ${ageCount(user.dateOfBirth.replaceAll('/', '-'))}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: ColorRes.primaryColor,
                                )),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.book, color: ColorRes.primaryColor),
                            title: Text(
                              "${user.jobTitle}",
                              style: TextStyle(
                                  color: ColorRes.secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.favorite_rounded, color: ColorRes.primaryColor),
                            title: Text(
                              "${user.relation} ${
                                  user.relation=='Married' ||
                                      user.relation=='Currently Married' ||
                                      user.relation=='Divorced' ||
                                      user.relation=='Widowed' ? user.children : ""
                              }",
                              style: TextStyle(
                                  color: ColorRes.secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int ageCount(String date){
    return DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(date)).inDays~/365;
  }
}

class InfoMatch extends StatelessWidget {
  final MatchModel user;

  InfoMatch(this.user);

  @override
  Widget build(BuildContext context) {
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
                        return user.senderId != appState.id.toString() ?
                        user.senderMeta.media!=null &&  user.senderMeta.media.isNotEmpty?
                        CachedNetworkImage(
                            imageUrl: user.senderMeta.media[index2],
                            placeholder: (context, url) => Image.asset(
                              'asset/Icon/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover
                        )
                         : Image.asset(
                          'asset/Icon/placeholder.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ) : user.targetMeta.media!=null &&  user.targetMeta.media.isNotEmpty?
                        CachedNetworkImage(
                            imageUrl:  user.targetMeta.media[index2],
                            placeholder: (context, url) => Image.asset(
                              'asset/Icon/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover
                        )
                         : Image.asset(
                          'asset/Icon/placeholder.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: user.senderId != appState.id.toString() ? user.senderMeta.media.length : user.targetMeta.media.length,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 13,
                              color: ColorRes.secondaryColor,
                              activeColor: ColorRes.primaryColor)),
                      control: new SwiperControl(
                        color: ColorRes.primaryColor,
                        disableColor: ColorRes.secondaryColor,
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
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            subtitle: Text("${user.senderId != appState.id.toString() ? user.senderMeta.livingIn : user.targetMeta.livingIn}"
                                "\n\n${user.senderId != appState.id.toString() ? user.senderMeta.about : user.targetMeta.about}"),
                            title: Text(
                              "${user.senderId != appState.id.toString() ? user.senderMeta.name : user.targetMeta.name} "
                                  " ${ user.senderId != appState.id.toString() ? ageCount(user.senderMeta.dateOfBirth.replaceAll('/', '-')) : ageCount(user.targetMeta.dateOfBirth.replaceAll('/', '-'))}",
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
                                  color: ColorRes.primaryColor,
                                )),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.book, color: ColorRes.primaryColor),
                            title: Text(
                              "${user.senderId != appState.id.toString() ? user.senderMeta.jobTitle : user.targetMeta.jobTitle}",
                              style: TextStyle(
                                  color: ColorRes.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.favorite_rounded, color: ColorRes.primaryColor),
                            title: Text(
                              "${
                                  user.senderId != appState.id.toString() ? user.senderMeta.relation : user.targetMeta.relation
                              } ${ user.senderId != appState.id.toString() ?
                              user.senderMeta.relation=='Married' ||
                                  user.senderMeta.relation=='Currently Married' ||
                                  user.senderMeta.relation=='Divorced' ||
                                  user.senderMeta.relation=='Widowed' ? user.senderMeta.children : ""
                                  :
                              user.targetMeta.relation=='Married' ||
                                  user.targetMeta.relation=='Currently Married' ||
                                  user.targetMeta.relation=='Divorced' ||
                                  user.targetMeta.relation=='Widowed' ? user.targetMeta.children : ""

                              }",
                              style: TextStyle(
                                  color: ColorRes.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int ageCount(String date){
    return DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(date)).inDays~/365;
  }
}
