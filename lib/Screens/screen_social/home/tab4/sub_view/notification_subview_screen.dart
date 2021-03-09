import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/models/notification_data_model.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/util/color.dart';
import 'package:intl/intl.dart';

import 'notification_subview_viewmodel.dart';

class SubPage extends StatefulWidget {

  final NotificationDataModel notificationData;
  const SubPage({Key key, this.notificationData}) : super(key: key);

  // SubPage(NotificationDataModel notificationData);

  @override
  SubPageState createState() => SubPageState();
}

class SubPageState extends State<SubPage> {

  SubViewModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model ?? (model = SubViewModel(this));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(child: postView()
      ),
    );
  }


  postView() {

    String currentTime = "";
    DateTime dateTIme = DateTime.parse(widget.notificationData.dateNotified);
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

    return SingleChildScrollView(
      child:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5),
            color: ColorRes.primaryColor,
            boxShadow: [BoxShadow(color: ColorRes.black, blurRadius: 5.0, offset: Offset(0, 0), spreadRadius: 0.1)]
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userImgNameShow(currentTime),

/*                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: popUpMenuButton(index, model.socialPostShowList[index].id, false),
                    ),*/
                  /*  Row(
                      children: [
                        InkResponse(
                            onTap: () {
                              model.showPostApi();
                            },
                            child: Icon(Icons.refresh, color: Colors.black, size: 30)),
                        InkResponse (
                            onTap: () async {
                              // model.deletePostApi(model.socialPostShowList[index].id);
                              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: socialPostShowList)));
                              if(isRef) {
                                model.showPostApi();
                              }
                            },
                            child: Icon(Icons.edit, color: Colors.black, size: 30)),
                        InkResponse(
                            onTap: () {
                              model.deletePostApi(socialPostShowList.id);
                            },
                            child: Icon(Icons.delete, color: Colors.black, size: 30))
                      ],
                    )*/
                ],
              ),
            ), //appState.currentUserData

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                child: widget.notificationData.post[0].content != null && widget.notificationData.post[0].content.isNotEmpty ?
                Text(widget.notificationData.post[0].content, style: TextStyle(color: ColorRes.white), textAlign: TextAlign.left ) : Container()),

            widget.notificationData.notificationThumb != null && widget.notificationData.notificationThumb.isNotEmpty ? Container(
              height: MediaQuery.of(context).size.height - 400,
              // height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: PageView.builder(
                  itemCount: 1 ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index1) {
                    return CachedNetworkImage(
                        imageUrl: widget.notificationData.notificationThumb,
                        placeholder: (context, url) => Image.asset (
                            'asset/Icon/placeholder.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover ),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover
                    );
                  }),
            )  :  Container(),
            // likeComment(index, socialPostShowList),
          ],
        ),
      ),
    );
    /*return Stack(
      children: [

        // likeEmojisView(index, socialPostShowList)
      ],
    );*/
  }


  userImgNameShow(String currentTime) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
        //     userId: int.parse(model.socialPostShowList[index].userId),
        //     isFollow: true)));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
                height: 25,
                width: 25,
                image: NetworkImage(widget.notificationData.notificationThumb)),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.notificationData.senderName }",  style: TextStyle(color: ColorRes.white), overflow: TextOverflow.ellipsis, maxLines: 1),
              Text(currentTime, style: TextStyle(color: ColorRes.greyBg, fontSize: 12))
            ],
          ),
        ],
      ),
    );
  }

}
