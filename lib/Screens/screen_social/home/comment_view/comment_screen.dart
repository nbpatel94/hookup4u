import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/models/getPostDataModel.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:intl/intl.dart';
import 'comment_viewmodel.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({Key key, this.postId}) : super(key: key);

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {


  bool isBottomFiled = false;
  String commentId = "-1";
  CommentViewModel model;
  FocusNode focusComment = FocusNode();
  TextEditingController commentController = TextEditingController();

  var refreshKey = GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // model.showCommentApi();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    model ?? (model = CommentViewModel(this));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: ColorRes.primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            color: ColorRes.primaryColor,
            padding: EdgeInsets.only(left: 15),
            child: Text("Comments",
                style: TextStyle(fontSize: 25, color: ColorRes.white)),
          ),
          Expanded(
              child: model.commentData.length == 0 ? Center(child: Text("No Data Foutnd"),) :
              RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                 child: ListView.builder(
                    itemCount:  model.commentData != null && model.commentData.length != 0 ? model.commentData.length : 0 ,
                    itemBuilder: (context, index) {

                      return listDataShow(index, model.commentData[index]);
                    }),
               )),
          inputCommentView()
        ],
      ),
    );
  }

  listDataShow(int index, CommentData commentData) {

    String currentTime = "";
    DateTime dateTIme = DateTime.parse(commentData.commentDate);
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

    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorRes.primaryColor,
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(right: 10, top: 8, left: 5),
                  decoration: BoxDecoration(
                      color: ColorRes.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: model.commentData[index].thumb != null && model.commentData[index].thumb.isNotEmpty
                        ? CachedNetworkImage(
                        imageUrl: model.commentData[index].thumb,
                        placeholder: (context, url) => Image.asset(
                            'asset/Icon/placeholder.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover)
                        : Image.asset(
                        'asset/Icon/placeholder.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.commentData[index].userName ?? "",
                      style: TextStyle(color: ColorRes.white, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  Text(currentTime,
                      style: TextStyle(color: ColorRes.greyBg, fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              )
            ],
          ),

          Padding(
              padding: EdgeInsets.only(left: 55),
              child: Text(model.commentData[index].commentContent ?? "",
                  style: TextStyle(color: ColorRes.white, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 25)),

          InkWell(
            onTap: () {

              FocusScope.of(context).requestFocus(focusComment);
              // FocusScope.of(context).focusComment();
              commentId = model.commentData[index].commentId;
              setState(() {
                isBottomFiled = true;
              });

            },
            child: Padding(
                padding: EdgeInsets.only(left: 50, top: 10),
                child: Text("Replay", style: TextStyle(color: ColorRes.primaryRed))),
          ),

          commentId == model.commentData[index].commentId ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(height: 50,
                width: MediaQuery.of(context).size.width - 150,
                child: TextField(
                controller: commentController,
                focusNode: focusComment,
                autofocus: true,
                style: TextStyle(color: ColorRes.white),
                cursorColor: ColorRes.white,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: ColorRes.white),
                  hintText: "Replay comment",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.white),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.white),
                  ),
                ),
              )),

              SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      icon: Icon(Icons.close, color: ColorRes.primaryRed),
                      onPressed: () {

                        isBottomFiled = false;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        commentId = "-1";
                        setState(() {});


                        // model.addCommentApi(widget.postId, "");
                      })),
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                            icon: Icon(Icons.send, color: ColorRes.primaryRed),
                            onPressed: () {
                              model.addCommentApi(widget.postId, model.commentData[index].commentId);
                              isBottomFiled = false;
                              commentId = "-1";
                              setState(() {});
                            }))
                  ],
          ) : Container(),


          subViewData(index, commentData),

          Padding(
              padding: EdgeInsets.only(left: 50, top: 20),
              child: Divider(
                height: 3,
                color: ColorRes.black,
              )),
        ],
      ),
    );
  }

  inputCommentView() {
    return isBottomFiled ? Container() : Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: ColorRes.black,
      child: Row(
        children: [
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: ColorRes.greyBg,
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: commentController,
                style: TextStyle(color: ColorRes.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a comment ...",
                  hintStyle: TextStyle(color: ColorRes.white),
                ),
              )),
          SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  icon: Icon(Icons.send, color: ColorRes.primaryRed),
                  onPressed: () {
                    model.addCommentApi(widget.postId, "");
                  }))
        ],
      ),
    );
  }

  subViewData(int index, CommentData commentData) {



    return Container(
      // height: 200,
      width: Utils().getDeviceWidth(context) - 100,
      child: ListView.builder(
          itemCount: commentData.childComment.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index1) {

            String currentTime = "";
            DateTime dateTIme = DateTime.parse(commentData.childComment[index1].commentDate);
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

        return Container(
          // height: 20,
          width: Utils().getDeviceWidth(context) - 100,
          margin: EdgeInsets.only(left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(right: 10, top: 8),
                      decoration: BoxDecoration(
                        color: ColorRes.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: model.commentData[index].thumb != null && model.commentData[index].thumb.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: commentData.childComment[index1].thumb,
                                    placeholder: (context, url) => Image.asset(
                                        'asset/Icon/placeholder.png',
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover)
                                : Image.asset('asset/Icon/placeholder.png',
                                    height: 120, width: 120, fit: BoxFit.cover),
                          )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.commentData[index].userName ?? "",
                          style: TextStyle(color: ColorRes.white, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      Text(currentTime,
                          style: TextStyle(color: ColorRes.greyBg, fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                    ],
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(commentData.childComment[index1].commentContent ?? "",
                      style: TextStyle(color: ColorRes.white, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 25)),
            ],
          ),
        );
      }),
    );
  }
}
