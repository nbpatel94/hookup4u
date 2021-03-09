import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/models/notification_data_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:intl/intl.dart';

import 'notification_detail_viewmodel.dart';
import 'sub_view/notification_subview_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {
  @override
  NotificationDetailsScreenState createState() => NotificationDetailsScreenState();
}

class NotificationDetailsScreenState extends State<NotificationDetailsScreen> {

  var refreshKey = GlobalKey<RefreshIndicatorState>();



  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    // setState(() {
    //   // model.showCommentApi();
    // });
    return null;
  }

  NotificationListDataViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model ?? (model = NotificationListDataViewModel(this));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                child: Text("Notifications", style: TextStyle(color: ColorRes.white, fontSize: 30))),
            Expanded(child: model.notificationDataEmpty ? Container() : RefreshIndicator (
              key: refreshKey,
              onRefresh: refreshList,
              child: model.notificationData != null && model.notificationData.length != 0 ?  ListView.separated(
                  itemCount: model.notificationData.length,
                  separatorBuilder: (context, index) {
                    return Padding (
                        padding: EdgeInsets.only(left: 60),
                        child: Divider(height: 1, color: ColorRes.black));
                  },
                  itemBuilder: (context, index) {
                return cellDataShow(index, model.notificationData[index]);
              }) : Container(child: Text("Notification data empty!")),
            ))
          ],
        ),
      ),
    );
  }

  cellDataShow(int index, NotificationDataModel notificationData) {
    // if(index == 0) {
    if(notificationData.componentName == "user_follow") {
      return InkResponse(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage(notificationData: notificationData)));
        },
        child: Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect (
                  borderRadius: BorderRadius.circular(40),
                  child: notificationData.notificationThumb != null && notificationData.notificationThumb.isNotEmpty ?
                  CachedNetworkImage (
                      imageUrl: notificationData.notificationThumb,
                      placeholder: (context, url) => Image.asset (
                          'asset/Icon/placeholder.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover ),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover
                  ) : Image (
                      height: 40,
                      width: 40,
                      image: AssetImage("asset/Icon/placeholder.png")
                  )
              ),

              SizedBox(width: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${notificationData?.senderName ?? ""} followed you " , style: TextStyle(color: ColorRes.white)),
                  // Text("jimmy Nilson followed you.", style: TextStyle(color: ColorRes.white)),
                  SizedBox(height: 10),
                  Text(timeCalculate(notificationData.dateNotified), style: TextStyle(color: ColorRes.greyBg)),
                ],
              )
            ],
          ),
        ),
      );
    } else if(notificationData.componentName == "friends") {
      return InkResponse(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage(notificationData: notificationData)));
        },
        child: Container (
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect (
                  borderRadius: BorderRadius.circular(40),
                  child: notificationData.notificationThumb != null && notificationData.notificationThumb.isNotEmpty ?
                  CachedNetworkImage (
                      imageUrl: notificationData.notificationThumb,
                      placeholder: (context, url) => Image.asset (
                          'asset/Icon/placeholder.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover ),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover
                  ) : Image (
                      height: 40,
                      width: 40,
                      image: AssetImage("asset/Icon/placeholder.png")
                  )
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${notificationData?.senderName ?? ""} friend request send you. ", style: TextStyle(color: ColorRes.white)),
                  // Text("jimmy Nilson followed you.", style: TextStyle(color: ColorRes.white)),
                  SizedBox(height: 10),
                  Text("2 hours ago", style: TextStyle(color: ColorRes.greyBg)),
                ],
              )
            ],
          ),
        ),
      );
    } else if(notificationData.componentName == "likes") {
      return InkResponse(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage(notificationData: notificationData)));
        },
        child: Container (
          height: 100,
          child: Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect (
                  borderRadius: BorderRadius.circular(40),
                  child: notificationData.notificationThumb != null && notificationData.notificationThumb.isNotEmpty ?
                  CachedNetworkImage (
                      imageUrl: notificationData.notificationThumb,
                      placeholder: (context, url) => Image.asset (
                          'asset/Icon/placeholder.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover ),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover
                  ) : Image(
                      height: 40,
                      width: 40,
                      image: AssetImage("asset/Icon/placeholder.png")
                  )
              ),
              SizedBox(width: 10),
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${notificationData.senderName} like your post", style: TextStyle(color: ColorRes.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                  // Text("Katie Malone liked 3 your photos", style: TextStyle(color: ColorRes.white)),
                  SizedBox(height: 3),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 90,
                    child: ListView.builder(
                        itemCount: notificationData?.post?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index1) {
                      return notificationData.post[0].media != null && notificationData.post[0].media.isNotEmpty ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage (
                            imageUrl: notificationData.post[0].media,
                            placeholder: (context, url) => Image.asset (
                                'asset/Icon/placeholder.png',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover
                            ),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover
                        ),
                      ) : Container(
                        child: Text(notificationData?.post[index]?.content ?? "", style: TextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                      );
                    }),
                  ),
                  SizedBox(height: 3),
                  Text(timeCalculate(notificationData.dateNotified), style: TextStyle(color: ColorRes.greyBg)),
                ],
              )
            ],
          ),
        ),
      );
    } /*else if(index == 2) {
      return Container(
        // height: 60,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                    height: 50,
                    width: 50,
                    image: AssetImage("asset/Icon/placeholder.png"), fit: BoxFit.cover)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(notificationData.action, style: TextStyle(color: ColorRes.white), maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text('Ola Gonzales reacts for story "killin\' chillin" to your timeline', style: TextStyle(color: ColorRes.white), maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  Text("2 hours ago", style: TextStyle(color: ColorRes.greyBg)),
                ],
              ),
            )
          ],
        ),
      );
    }*/ else if(notificationData.componentName == "comments") {
      return InkResponse(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage(notificationData: notificationData)));
        },
        child: Container(
          // height: 60,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  ClipRRect (
                  borderRadius: BorderRadius.circular(40),
                    child: notificationData.notificationThumb != null && notificationData.notificationThumb.isNotEmpty ?
                    CachedNetworkImage (
                        imageUrl: notificationData.notificationThumb,
                        placeholder: (context, url) => Image.asset (
                            'asset/Icon/placeholder.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover ),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover
                    ) : Image(
                        height: 40,
                        width: 40,
                        image: AssetImage("asset/Icon/placeholder.png")
                    )
                ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${notificationData.senderName} commented your post", style: TextStyle(color: ColorRes.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          notificationData?.comment != null && notificationData.comment.isNotEmpty ?

                          Expanded(
                              child: Text("${notificationData?.comment[0]?.commentContent ?? ""}",
                                  style: TextStyle(color: ColorRes.white), maxLines: 2, overflow: TextOverflow.ellipsis)) :
                          Container(child: Text("Comment empty")),

                         notificationData.post[0].media != null && notificationData.post[0].media.isNotEmpty ?
                         ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage (
                                imageUrl: notificationData.post[0].media,
                                placeholder: (context, url) => Image.asset (
                                    'asset/Icon/placeholder.png',
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover
                                ),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover
                            ),
                          ) : Container()

                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(timeCalculate(notificationData.dateNotified), style: TextStyle(color: ColorRes.greyBg)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } /*else if(index == 4) {
      return Container(
        // height: 60,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                    height: 50,
                    width: 50,
                    image: AssetImage("asset/Icon/placeholder.png"), fit: BoxFit.cover)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Austin Gonzales added 5 photos', style: TextStyle(color: ColorRes.white), maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 90,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index1) {
                          return Image(
                              height: 70,
                              width: 70,
                              image: AssetImage("asset/Icon/placeholder.png"));
                        }),
                  ),
                  SizedBox(height: 10),
                  Text("2 hours ago", style: TextStyle(color: ColorRes.greyBg)),
                ],
              ),
            )
          ],
        ),
      );
    }*/
    else {
      return Container();
    }





  }


  timeCalculate(String dateTime) {
    String currentTime = "";
    DateTime dateTIme = DateTime.parse(dateTime);
    final date2 = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(date2);
    DateTime utcTime = DateTime.parse(formatted);
    final days = utcTime.difference(dateTIme).inDays;
    final hours = utcTime.difference(dateTIme).inHours;
    final minutes = utcTime.difference(dateTIme).inMinutes;

    if(minutes <= 60) {
      currentTime = "$minutes minutes ago";
    } else if(hours <= 24) {
      currentTime = "$hours hours ago";
    } else if(days > 0) {
      currentTime = "$days days ago";
    }
    // setState(() {});
    return currentTime;
  }

}
