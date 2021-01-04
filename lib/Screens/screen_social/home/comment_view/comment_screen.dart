import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'comment_viewmodel.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({Key key, this.postId}) : super(key: key);

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {


  bool isReplay = false;
  CommentViewModel model;
  TextEditingController commentController = TextEditingController();

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
            child: Text("Comment",
                style: TextStyle(fontSize: 25, color: ColorRes.white)),
          ),
          Expanded(
              // model.commentData.length == 0 ? Center(child: Text("No Data Foutnd"),) :
              child:  ListView.builder(
                  itemCount:  10,
                  // itemCount:  model.commentData != null && model.commentData.length != 0? model.commentData.length : 0,
                  itemBuilder: (context, index) {
                    return listDataShow(index);
                  })),
          inputCommentView()
        ],
      ),
    );
  }

  listDataShow(int index) {
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
                  height: 50,
                  width: 50,
                  color: ColorRes.primaryColor,
                  child: Icon(Icons.person)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" hellohello",
                  // Text(model.commentData[index].userName ?? " hello",
                      style: TextStyle(color: ColorRes.white, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  Text("2 hours ago.",
                      style: TextStyle(color: ColorRes.greyBg, fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text("HEllo  worldHEllo  worldHEllo  worldHEllo  worldHEllo  world",
              // child: Text(model.commentData[index].commentContent ?? "Name",
                  style: TextStyle(color: ColorRes.white, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 25)),
          InkWell(
            onTap: () {
              setState(() {
                isReplay = true;
              });
            },
            child: Padding(
                padding: EdgeInsets.only(left: 50, top: 10),
                child: Text("Replay", style: TextStyle(color: ColorRes.primaryRed))),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(height: 50,
                width: MediaQuery.of(context).size.width - 100,
                child: TextField(
                controller: commentController,
                style: TextStyle(color: ColorRes.white),
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
                      icon: Icon(Icons.send, color: ColorRes.primaryRed),
                      onPressed: () {
                        model.addCommentApi(widget.postId, "");
                      }))
            ],
          ),

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
    return Container(
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
}
