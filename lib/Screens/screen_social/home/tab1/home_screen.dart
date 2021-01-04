import 'package:cached_network_image/cached_network_image.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/comment_view/comment_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/post_data/post_data_screen.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

import 'edit/edit_screen.dart';
import 'home_viewmodel.dart';

class SocialHomePage extends StatefulWidget {

  final TabController tabController;
  const SocialHomePage({Key key, this.tabController}) : super(key: key);


  @override
  SocialHomePageState createState() => SocialHomePageState();
}

class SocialHomePageState extends State<SocialHomePage> {

  bool isRef = false;
  String postIdStr = "0";

  TextEditingController commentController = TextEditingController(text: "🍇, 🍈, 🍉");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final loveEmojis = Emoji.byKeyword('love'); // returns list of lovely emojis :)
    print(loveEmojis);
    print(commentController.text);

  }
  
  SocialHomeViewModel model;
  
  @override
  Widget build(BuildContext context) {
    model ?? (model = SocialHomeViewModel(this));
    return Material(
      color: ColorRes.primaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerView(),
            // storyView(),
            showUserData()
          ],
        ),
      ),
    );
  }

  headerView() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: ColorRes.white),
            onPressed: ()  {
            Navigator.pop(context);
            }),
        Container(
            width: Utils().getDeviceWidth(context) - 110,
            height: 40,
            decoration: BoxDecoration(
              color: ColorRes.greyBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(60),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            )
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: FloatingActionButton(
            onPressed: () async {
              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isShare: false, postId: "")));
              if (isRef) {
                model.showPostApi();
              }
            },
            backgroundColor: ColorRes.primaryRed,
            child: Container(
              height: 40,
              width: 40,
              child: Icon(Icons.add, color: ColorRes.white, size: 35),
            ),
          ),
        )
      ]),
    );
  }

  storyView() {
    return Container(
      height: 250,
      width: Utils().getDeviceWidth(context),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 20),
                  child: Text("View all", style: TextStyle(color: ColorRes.primaryRed)))),
          Text("Streams"),
          Container(
            height: 150,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
              return Container(
                height: 150,
                width: 125,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: ColorRes.greyBg,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("hello"),
              );
            }),
          )
        ],
      ),
    );
  }

  showUserData() {
    return model.socialPostShowList.length == 0 ?
    Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
        child: Text("No Data Found")) :
    ListView.builder(
        itemCount: model.socialPostShowList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
      return showView(index);
    });
  }

  showView(int index) {
    if(model.socialPostShowList[index].parentPost != null) {
      return sharingViewShow(index);
    } else {
      return postView(index);
    }
  }


  likeCommentShare(String title, int index, String postId) {
    return InkResponse(
      onTap: () async {
        if (index == 1) {

        } else if(index == 2) {

          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(postId: postId)));

          /*setState(() {
            postIdStr = postId;
          });*/

        } else if(index == 3) {
          isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isShare: true, postId: postId)));
          if (isRef) {
            model.showPostApi();
          }
        }
      },
      child: Text(title, style: TextStyle(color: ColorRes.black)),
    );
  }

  postView(int index){
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    userImgNameShow(index),

                    Row(
                      children: [
                        InkResponse(
                            onTap: () {
                              model.showPostApi();
                            },
                            child: Icon(Icons.refresh, color: Colors.black, size: 30)),
                        InkResponse(
                            onTap: () async {
                              // model.deletePostApi(model.socialPostShowList[index].id);
                              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: model.socialPostShowList[index])));
                              if(isRef) {
                                model.showPostApi();
                              }
                            },
                            child: Icon(Icons.edit, color: Colors.black, size: 30)),
                        InkResponse(
                            onTap: () {
                              model.deletePostApi(model.socialPostShowList[index].id);
                            },
                            child: Icon(Icons.delete, color: Colors.black, size: 30))
                      ],
                    )
                  ],
                ),
              ), //appState.currentUserData

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: model.socialPostShowList[index].content != null && model.socialPostShowList[index].content.isNotEmpty ?
                  Text(model.socialPostShowList[index].content, style: TextStyle(color: ColorRes.white), textAlign: TextAlign.left ) : Container()),

              Container(
                height: MediaQuery.of(context).size.height  - 400,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PageView.builder(
                    itemCount: model.socialPostShowList[index].media.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index1) {
                      return model.socialPostShowList[index].media != null && model.socialPostShowList[index].media[index1].isNotEmpty
                          ? CachedNetworkImage(
                          imageUrl: model.socialPostShowList[index].media[index1],
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
                      );
                    }),
              ),

              /*Expanded(child: Image(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(model.socialPostShowList[index].media[0]))),*/


              Container(
                height: 50,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    likeCommentShow("1 like"),
                    likeCommentShow("1 comment"),
                  ],
                ),
              ),

              Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.socialPostShowList[index].id),
                    likeCommentShare("Comment",2, model.socialPostShowList[index].id),
                    likeCommentShare("Share",3, model.socialPostShowList[index].id),
                  ],
                ),
              )
            ],
          ),
        ),

        postIdStr == model.socialPostShowList[index].id ? Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 25),
            decoration: BoxDecoration(
              color: Colors.white60,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: TextField(
              controller: commentController,
                decoration: InputDecoration(
                    hintText: 'Comment',
                    border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
            )) : Container()
      ],
    );
  }

  sharingViewShow(int index, ) {
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userImgNameShow(index),
                    Row(
                      children: [
                        InkResponse(
                            onTap: () async {
                              // model.deletePostApi(model.socialPostShowList[index].id);
                              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: model.socialPostShowList[index])));
                              if(isRef) {
                                model.showPostApi();
                              }},
                            child: Icon(Icons.edit, color: Colors.black, size: 30)),

                        InkResponse(
                            onTap: () {
                              model.deletePostApi(model.socialPostShowList[index].id);
                            },
                            child: Icon(Icons.delete, color: Colors.black, size: 30))
                      ],
                    )
                  ],
                ),
              ), //appState.currentUserData

              Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Text(model.socialPostShowList[index].content)),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Padding(padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: Text(model.socialPostShowList[index].parentPost.userName)),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                        child: model.socialPostShowList[index].parentPost.content != null && model.socialPostShowList[index].parentPost.content.isNotEmpty ?
                        Text(model.socialPostShowList[index].parentPost.content, style: TextStyle(), textAlign: TextAlign.left ) : Container()),
                    Container(
                      height: MediaQuery.of(context).size.height  - 400,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: PageView.builder(
                          itemCount: model.socialPostShowList[index].parentPost.media.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            return model.socialPostShowList[index].parentPost.media != null && model.socialPostShowList[index].parentPost.media[index1].isNotEmpty
                                ? CachedNetworkImage(
                                imageUrl: model.socialPostShowList[index].parentPost.media[index1],
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
                            );
                          }),
                    ),

                  ],
                ),
              ),

              Container(
                height: 50,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    likeCommentShow("10 like"),
                    likeCommentShow("3 comment"),
                  ],
                ),
              ),

              Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.socialPostShowList[index].parentPost.id),
                    likeCommentShare("Comment",2, model.socialPostShowList[index].parentPost.id),
                    likeCommentShare("Share",3, model.socialPostShowList[index].parentPost.id),
                  ],
                ),
              )
            ],
          ),
        ),

        postIdStr == model.socialPostShowList[index].id ? Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 25),
            decoration: BoxDecoration(
                color: Colors.white60,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8)
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Comment',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            )) : Container()
      ],
    );
  }

  userImgNameShow(int index){
    return Row(
      children: [
        InkResponse(
          onTap: () {
            widget.tabController.animateTo(3, duration: Duration(milliseconds: 500));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
                height: 25,
                width: 25,
                image: NetworkImage(model.socialPostShowList[index].thumb)),
          ),
        ),
        SizedBox(width: 8),
        Text("${model.socialPostShowList[index].userName }",  style: TextStyle(color: ColorRes.white), overflow: TextOverflow.ellipsis, maxLines: 1),
      ],
    );
  }

  likeCommentShow(String title) {
    return InkWell(
      onTap: () {

      },
      child: Text("$title", style: TextStyle(color: ColorRes.white), maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
