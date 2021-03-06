import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/comment_view/comment_screen.dart';
import 'package:hookup4u/Screens/screen_social/follower_view/follower_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/post_data/post_data_screen.dart';
import 'package:hookup4u/Screens/screen_social/like_show/like_show_screen.dart';
import 'package:hookup4u/Screens/screen_social/user_profile_view/user_profile_viewmodel.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/user_profile_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/widget/social_card_view/social_card_view.dart';
import 'package:intl/intl.dart';
// import 'package:hookup4u/widget/social_card_view/social_card_view.dart' as cardView;
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

class UserProfilePage extends StatefulWidget {

  final int userId;
  final bool isFollow;
  final bool isOpenRequestScreen;

  const UserProfilePage({Key key, this.userId, this.isFollow, this.isOpenRequestScreen = false}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {

  List<String> emojis = ["👍","❤️","😘","🤣","😡","😥"];
  int isSelected = 1;
  bool isRef = false;
  String postIdStr = "0";

  bool isShowFollowUnFollow = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isShowFollowUnFollow = widget.isFollow;
    setState(() {});
  }

  UserProfileViewModel model;

  @override
  Widget build(BuildContext context) {

    model ?? (model = UserProfileViewModel(this));

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, model.isChangesThisScreen);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorRes.greyBg,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context, model.isChangesThisScreen);
          }),
         /* actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert, color: ColorRes.white, size: 30), onPressed: () {}),
          ],*/
        ),
        body: !model.isEmptyMessageShow ? Container() : model?.userProfileModel?.data?.userDetail == null?
        Center(
          child: Container(
            alignment: Alignment.center,
            child: Text("User Profile Not Available!", style: TextStyle(color: ColorRes.white, fontSize: 20)),
          ),
        ) : SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              topUserImageView(),
              followerDataShow(),
              tabIconShow(),

              //  Container(
              //   height: 150,
              //   child: TabBarView(
              //     physics: NeverScrollableScrollPhysics(),
              //     children: [
              //
              //       showMyPost(),
              //       new Text("This is chat Tab View"),
              //       new Text("This is notification Tab View"),
              //       new Text("This is notification Tab View"),
              //     ],
              //     controller: _tabController
              //   ),
              // ),

              // showMyPost()

              isSelected == 1 ? showMyPost() : Container(),
              isSelected == 2 ? mediaListShow() : Container(),
              isSelected == 3 ? Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Text("No Data")) : Container(),
              isSelected == 4 ? Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Text("No Data")): Container(),



              // SocialPostView(userProfileModel: model.userProfileModel)
            ],
          ),
        ),
      ),
    );
  }

  topUserImageView() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      color: ColorRes.greyBg,
      padding: EdgeInsets.only(bottom: 15),
      // color: Colors.white60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Container(
              height: 70,
              width: 70,
              // height: MediaQuery.of(context).size.width / 3,
              // width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
              margin: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(125),
                child: model.userProfileModel?.data?.thumb != null &&
                    model.userProfileModel.data.thumb.isNotEmpty
                    ? CachedNetworkImage(
                    imageUrl: model.userProfileModel.data.thumb,
                    placeholder: (context, url) => Image.asset(
                      'asset/Icon/placeholder.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover)
                    : Image.asset(
                  'asset/Icon/placeholder.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              )),

          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model?.userProfileModel?.data?.userDetail?.displayName ?? "", style: TextStyle(color: ColorRes.white, fontSize: 21), overflow: TextOverflow.ellipsis, maxLines: 1),
                Text("@${model?.userProfileModel?.data?.userDetail?.userNicename}" ?? "", style: TextStyle(color: ColorRes.white, fontSize: 14),  overflow: TextOverflow.ellipsis, maxLines: 1),
                SizedBox(height: 15),
              ])
        ],
      ),
    );
  }

  followerDataShow() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          followerCountShow(model?.userProfileModel?.data?.posts?.toString() ?? "0", "Posts"),
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FollowerFollowingList(isCheckScreen: "Following")));
            },
            child: followerCountShow(model?.totalFollowing.toString() ?? "0", "Following"),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FollowerFollowingList(isCheckScreen: "Follower")));
            },
            child: followerCountShow(model?.userProfileModel?.data?.follower?.toString() ?? "0", "Follower"),
          ),

          widget.isOpenRequestScreen ? Row(children: [
            InkWell(onTap: () {
              model.acceptFriendRequestApi(widget.userId.toString());
            }, child: Icon(Icons.check, color: ColorRes.primaryRed)),
            SizedBox(width: 15),
            InkWell(onTap: () {
              model.deleteFriendsRequest(widget.userId.toString());
            }, child: Icon(Icons.delete, color: ColorRes.primaryRed))
          ]) : InkResponse (
            onTap: () {
              model.friendRequestApi();
            },
            child: Container (
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade200
              ),
              child: Icon(Icons.person_add_alt_1, color: ColorRes.white, size: 20),
            ),
          ),

          InkResponse(
            onTap: () {
              model.userFollowApi(widget.userId.toString());
            },
            child: Container(
              height: 30,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorRes.primaryRed,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Text(isShowFollowUnFollow ? "UnFollow" : "Follow", style: TextStyle(color: ColorRes.white, fontSize: 15), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }

  followerCountShow(String countShow, String title){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(countShow, style: TextStyle(color: ColorRes.white, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 1),
        SizedBox(width: 5),
        Text(title, style: TextStyle(color: ColorRes.greyBg, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 1),
      ],
    );
  }

  tabIconShow(){

    return Container(
      height: 50,
      color: ColorRes.tabBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Icon(Icons.grid_view, color: ColorRes.white,),
          InkResponse(
            onTap: () {
              setState(() {
                isSelected = 1;
              });
            },
            child: Image(
              height: 20,
              width: 20,
              image: AssetImage("asset/Icon/grid.png"),
              color: isSelected == 1? ColorRes.primaryRed : Colors.white,
            ),
          ),
          InkResponse(
              onTap: () {
                setState(() {
                  isSelected = 2;
                });
              },
              child: Icon(Icons.image, color: isSelected == 2  ? ColorRes.primaryRed :ColorRes.white)),
          InkResponse(
              onTap: () {
                setState(() {
                  isSelected = 3;
                });
              },
              child: Icon(Icons.play_circle_fill, color: isSelected == 3 ? ColorRes.primaryRed : ColorRes.white)),
          InkResponse(
              onTap: () {
                setState(() {
                  isSelected = 4;
                });
              },
              child: Icon(Icons.music_note_rounded, color: isSelected == 4? ColorRes.primaryRed : ColorRes.white)),
        ],
      ),
    );
  }

  showMyPost() {
    print(model.userProfileModel);
    if(model.userProfileModel?.data?.userPosts?.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          alignment: Alignment.center,
          child: Text("No Data Found"));
    } else {
      return  model.userProfileModel?.data == null || model.userProfileModel.data.userPosts == null || model.userProfileModel.data.userPosts.isEmpty ? Container() :
      Container(
        width: kIsWeb ? MediaQuery.of(context).size.height / 2.0 : MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: model.userProfileModel.data.userPosts.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return showView(index, model.userProfileModel.data.userPosts[index]);
            }),
      );
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
                  child: Text(userPost.content, style: TextStyle(color: ColorRes.white))),

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
        // isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isEdit: true, postId: postId)));
        // if (isRef) {
        //   // model.showMyPostApi();
        // }
        break;
      case 'Edit':
        if(isShare) {
          // isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: userProfileModel.data.userPosts[index], isShare: true)));
          // if (isRef) {
          //   // model.showMyPostApi();
          // }
        } else {
          // isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: userProfileModel.data.userPosts[index], isShare: false)));
          // if(isRef) {
          //   // model.showMyPostApi();
          // }
        }
        break;
      case 'Delete':
        // model.deletePostApi(userProfileModel.data.userPosts[index].id);
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
                height: 50,
                width: 50,
                image: NetworkImage(model.userProfileModel.data.userPosts[index].thumb)),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${model.userProfileModel.data.userPosts[index].userName }",  style: TextStyle(color: ColorRes.white), overflow: TextOverflow.ellipsis, maxLines: 1),
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
                      // model.deletePostApi(userPost.id);
                      model.deleteLikeApi(userPost.id);
                    } else {
                      model.addLikeApi(userPost.id, "#like");
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
                      child: Icon(Icons.favorite_border_outlined, color: Colors.white))
              ),

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


  mediaListShow() {
    if(model.isEmptyMessageUserMedia) {
      return Container();
    } else {
      if (model?.userMediaProfileApi?.data != null &&
          model?.userMediaProfileApi?.data?.length != 0) {
        return Container(
          width: kIsWeb ? MediaQuery.of(context).size.height / 2.0 : MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: model.userMediaProfileApi.data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return userProfileImages(
                    index, model.userMediaProfileApi.data[index]);
              }),
        );
      } else {
        return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            alignment: Alignment.center,
            child: Text("No Post Available")
        );
      }
    }
  }

  userProfileImages(int index, String data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorRes.primaryColor,
          boxShadow: [BoxShadow(color: ColorRes.black, blurRadius: 5.0, offset: Offset(0, 0), spreadRadius: 0.1)]
      ),
      child: Image(image: NetworkImage(data), fit: BoxFit.contain),
    );
  }

}
