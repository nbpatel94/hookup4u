import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/comment_view/comment_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/edit/edit_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/post_data/post_data_screen.dart';
import 'package:hookup4u/Screens/screen_social/like_show/like_show_screen.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/models/user_profile_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/widget/social_card_view/social_card_viewmodel.dart';
import 'package:intl/intl.dart';


class SocialPostView extends StatefulWidget {

  final UserProfileModel userProfileModel;
  const SocialPostView({Key key, this.userProfileModel}) : super(key: key);

  @override
  SocialPostViewState createState() => SocialPostViewState();
}

class SocialPostViewState extends State<SocialPostView> {

  List<String> emojis = ["👍","❤️","😘","🤣","😡","😥"];
  String postIdStr = "0";
  int isSelected = 1;
  bool isRef = false;

  UserProfileModel userProfileModel = UserProfileModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model ?? (model == SocialCardViewModel(this));


    userProfileModel = widget.userProfileModel;
    setState(() {});
    // for (int i = 0; i < widget.userProfileModel.data.userPosts.length; i++) {
    //   model.showMyPostList[i].id = widget.userProfileModel.data.userPosts[i].id;
    //   model.showMyPostList[i].userId  = widget.userProfileModel.data.userPosts[i].userId;
    //   model.showMyPostList[i].content  = widget.userProfileModel.data.userPosts[i].content;
    //   model.showMyPostList[i].media  = widget.userProfileModel.data.userPosts[i].media;
    //   model.showMyPostList[i].visibility  = widget.userProfileModel.data.userPosts[i].visibility;
    //   // model.showMyPostList[i].parentPost  = widget.userProfileModel.data.userPosts[i].parentPostData;
    //   model.showMyPostList[i].postDate  = widget.userProfileModel.data.userPosts[i].postDate;
    //   model.showMyPostList[i].likeCount  = widget.userProfileModel.data.userPosts[i].likeCount;
    //   model.showMyPostList[i].commentCount  = widget.userProfileModel.data.userPosts[i].commentCount;
    // }

  }


  SocialCardViewModel model;

  @override
  Widget build(BuildContext context) {
    return showMyPost();
  }

  showMyPost() {

    print(userProfileModel);

    if(userProfileModel?.data?.userPosts?.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          alignment: Alignment.center,
          child: Text("No Data Found"));
    } else {
      return  userProfileModel.data == null || userProfileModel.data.userPosts.isEmpty ? Container() : ListView.builder(
          itemCount: userProfileModel.data.userPosts.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return showView(index, userProfileModel.data.userPosts[index]);
          });
    }
  }

  showView(int index, UserPosts userPost) {
    if(userPost.parentPostData != null) {
      return sharingViewShow(index, userPost);
    } else {
      return postView(index, userPost);
    }
  }

  sharingViewShow(int index, UserPosts userPost) {

    String currentTime = "";
    DateTime dateTIme = DateTime.parse(userPost.postDate);
    final date2 = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    print(formatter);
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

    return Stack(
      children: [
        Container(
          // height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5),
              color: ColorRes.primaryColor,
              boxShadow: [BoxShadow(color: ColorRes.black, blurRadius: 5.0, offset: Offset(0, 0), spreadRadius: 0.1)]

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

                    userImgNameShow(index, currentTime),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: popUpMenuButton(index, "2"/*model.socialPostShowList[index].parentPost.id*/, true),
                    ),
                    /*  Row(
                      children: [
                        InkResponse(
                            onTap: () async {
                              // model.deletePostApi(model.socialPostShowList[index].id);
                              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: model.showMyPostList[index])));
                              if(isRef) {
                                model.showMyPostApi();
                              }                            },
                            child: Icon(Icons.edit, color: Colors.black, size: 30)),

                        InkResponse(
                            onTap: () {
                              model.deletePostApi(model.showMyPostList[index].id);
                            },
                            child: Icon(Icons.delete, color: Colors.black, size: 30))
                      ],
                    )*/
                  ],
                ),
              ), //appState.currentUserData

              Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Text(userPost.content)),

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

                    SizedBox(height: 10),

                    Row(
                      children: [

                        SizedBox(width: 10),
                        InkResponse(
                          onTap: () {
                            // widget.tabController.animateTo(3, duration: Duration(milliseconds: 500));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                                height: 25,
                                width: 25,
                                image: NetworkImage(userPost.thumb)),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${userPost.userName }",  style: TextStyle(color: ColorRes.white), overflow: TextOverflow.ellipsis, maxLines: 1),
                            // Text(currentTime, style: TextStyle(color: ColorRes.greyBg, fontSize: 12))
                          ],
                        ),

                      ],
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 10),
                        child: userPost.content != null && userPost.content.isNotEmpty ?
                        Text(userPost.content, style: TextStyle(color: ColorRes.white), textAlign: TextAlign.left ) : Container()),


                    Container(
                      height: MediaQuery.of(context).size.height  - 400,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: PageView.builder(
                          itemCount: userPost.media.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            return userPost.media != null && userPost.media[index1].isNotEmpty
                                ? CachedNetworkImage(
                                imageUrl: userPost.media[index1],
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

              likeComment(index, userPost),

              /*   Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.showMyPostList[index].parentPost.id),
                    likeCommentShare("Comment",2, model.showMyPostList[index].parentPost.id),
                    likeCommentShare("Share",3, model.showMyPostList[index].parentPost.id),
                  ],
                ),
              )*/
            ],
          ),
        ),

        likeEmojisView(index, userPost)

        /* postIdStr == model.showMyPostList[index].id ? Container(
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
            )) : Container()*/
      ],
    );
  }

  postView(int index, UserPosts userPost) {

    String currentTime = "";
    DateTime dateTIme = DateTime.parse(userPost.postDate);
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

    return Stack(
      children: [
        Container(
          // height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorRes.primaryColor,
              boxShadow: [BoxShadow(color: ColorRes.black, blurRadius: 5.0, offset: Offset(0, 0), spreadRadius: 0.1)]
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

                    userImgNameShow(index, currentTime),

                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: popUpMenuButton(index, userPost.id, false),
                    ),

                    /* Row(
                      children: [
                        InkResponse(
                            onTap: () {
                              model.showMyPostApi();
                            },
                            child: Icon(Icons.refresh, color: Colors.black, size: 30)),
                        InkResponse(
                            onTap: () async {
                              // model.deletePostApi(model.socialPostShowList[index].id);
                              isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: model.showMyPostList[index])));
                              if(isRef) {
                                model.showMyPostApi();
                              }
                            },
                            child: Icon(Icons.edit, color: Colors.black, size: 30)),
                        InkResponse(
                            onTap: () {
                              model.deletePostApi(model.showMyPostList[index].id);
                            },
                            child: Icon(Icons.delete, color: Colors.black, size: 30))
                      ],
                    )*/
                  ],
                ),
              ), //appState.currentUserData

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: userPost.content != null && userPost.content.isNotEmpty ?
                  Text(userPost.content, style: TextStyle(color: ColorRes.white), textAlign: TextAlign.left ) : Container()),

              userPost.media != null && userPost.media[0].isNotEmpty ? Container(
                height: MediaQuery.of(context).size.height  - 400,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PageView.builder(
                    itemCount: userPost.media.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index1) {
                      return CachedNetworkImage(
                          imageUrl: userPost.media[index1],
                          placeholder: (context, url) => Image.asset(
                              'asset/Icon/placeholder.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover);

                    }),
              ) : Container() ,

              /*Expanded(child: Image(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(model.socialPostShowList[index].media[0]))),*/
              likeComment(index, userPost),

              /*   Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.showMyPostList[index].id),
                    likeCommentShare("Comment",2, model.showMyPostList[index].id),
                    likeCommentShare("Share",3, model.showMyPostList[index].id),
                  ],
                ),
              )*/
            ],
          ),
        ),

        likeEmojisView(index, userPost)

        /*    postIdStr == model.showMyPostList[index].id ? Container(
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
            )) : Container()*/
      ],
    );
  }

  popUpMenuButton(int index, String postId, bool isShare) {
    return PopupMenuButton<String>(
      color: ColorRes.white,
      child: Image(
          height: 25,
          width: 25,
          image: AssetImage('asset/Icon/menu.png')),
      // icon: Icon(Icons., color: ColorRes.white),
      onSelected: (value) {
        return handleClick(value, index, postId, isShare);
      },
      itemBuilder: (BuildContext context) {
        return {'Share'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Future<void> handleClick(String value, int index, String postId, bool isShare) async {
    switch (value) {
      case 'Share':
        isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isEdit: true, postId: postId)));
        if (isRef) {
          // model.showMyPostApi();
        }
        break;
      case 'Edit':
        if(isShare) {
          // isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: userProfileModel.data.userPosts[index], isShare: true)));
          if (isRef) {
            // model.showMyPostApi();
          }
        } else {
          // isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: userProfileModel.data.userPosts[index], isShare: false)));
          if(isRef) {
            // model.showMyPostApi();
          }
        }
        break;
      case 'Delete':
        model.deletePostApi(userProfileModel.data.userPosts[index].id);
        break;
    }
  }


  userImgNameShow(int index, String currentTime) {
    return Row(
      children: [
        InkResponse(
          onTap: () {
            // widget.tabController.animateTo(3, duration: Duration(milliseconds: 500));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
                height: 25,
                width: 25,
                image: NetworkImage(userProfileModel.data.userPosts[index].thumb)),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${userProfileModel.data.userPosts[index].userName }",  style: TextStyle(color: ColorRes.white), overflow: TextOverflow.ellipsis, maxLines: 1),
            Text(currentTime, style: TextStyle(color: ColorRes.greyBg, fontSize: 12))
          ],
        ),
      ],
    );
  }

  likeCommentShare(String title, int index, String postId) {
    return InkResponse(
      onTap: () async {
        if (index == 1) {

        } else if(index == 2) {
          setState(() {
            postIdStr = postId;
          });
        } else if(index == 3) {
          isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isEdit: true, postId: postId)));
          if (isRef) {
            // model.showPostApi();
          }
        }
      },
      child: Text(title),
    );
  }



  likeComment(int index, UserPosts userPost) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    if(userPost.selfLike) {
                      // model.deleteLikeApi(socialPostShowList.id);
                    } else {
                      // model.addLikeApi(socialPostShowList.id, "#like");
                    }
                  },
                  onLongPress: () {
                    // postIdStr = socialPostShowList.id;
                    setState(() {});
                  },
                  child:/* model.socialPostShowList[index].selfLike
                      ? Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Icon(Icons.favorite,
                              color: Colors.white))
                      :*/ Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(Icons.favorite_border_outlined, color: Colors.white))),

              // : Icon(Icons.favorite_border_outlined, color: Colors.white)

              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    if(userPost.likeCount != null  && userPost.likeCount != 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LikeShowScreen(postId: userPost.id)));
                    }
                  },
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(userPost.likeCount.toString() ?? "0", style: TextStyle(color: Colors.white)))),


              SizedBox(width: 20),
              InkResponse(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(postId: userPost.id)));
                  },
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(Icons.message, color: Colors.white))
              ),

              SizedBox(width: 15),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(postId: userPost.id)));
                  },
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(userPost.commentCount.toString() ?? "0", style: TextStyle(color: Colors.white)))),
            ],
          ),
          // Padding(
          //     padding: EdgeInsets.only(right: 10),
          //     child: Image(
          //         height: 35,
          //         width: 35,
          //         image: AssetImage('asset/Icon/layer.png'))),
        ],
      ),
    );
  }


  likeEmojisView(int index, UserPosts userPost) {
    return  Positioned(
        bottom: 40,
        child: postIdStr == userPost.id ?
        Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 150,
            margin: EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 25),
            padding: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration (
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(50)
            ),
            child: ListView.builder(
                itemCount: emojis.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

                      postIdStr = "-1";
                      if(index == 0) {
                        model.addLikeApi(userPost.id, "#like");
                      } else if(index == 1) {
                        model.addLikeApi(userPost.id, "#love");
                      } else if(index == 2) {
                        model.addLikeApi(userPost.id, "#care");
                      } else if(index == 3) {
                        model.addLikeApi(userPost.id, "#haha");
                      } else if(index == 4) {
                        model.addLikeApi(userPost.id, "#angry");
                      } else if(index == 5) {
                        model.addLikeApi(userPost.id, "#sad");
                      }
                    },

                    child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(emojis[index].toString(), style: TextStyle(fontSize: 30))),
                  );
                  /* return Image(
                  height: 40,
                  width: 40,
                  image: AssetImage("asset/Icon/${emojis[index]}.png"))*/;
                })
        ) : Container());
  }


}
