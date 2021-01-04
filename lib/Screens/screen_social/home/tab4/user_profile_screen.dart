import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/edit/edit_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/post_data/post_data_screen.dart';
import 'package:hookup4u/app.dart';

import 'user_profile_viewmodel.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {

  bool isRef = false;
  String postIdStr = "0";

  UserProfileViewModel model;
  @override
  Widget build(BuildContext context) {

    model ?? (model = UserProfileViewModel(this));

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
             topUserImageView(),
             showMyPost()
           
          ],
        ),
      ),
    );
  }

  topUserImageView() {
    return Container(
      height: 350,
      color: Colors.white60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width / 1.15,
              margin: EdgeInsets.only(left: 30, right: 30, top: 30),
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text("Cover Photo"),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    shape: BoxShape.circle
                ),
                margin: EdgeInsets.only(left: 30, right: 30),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(125),
                  child: appState.medialList!=null &&  appState.medialList.isNotEmpty?
                  CachedNetworkImage(
                      imageUrl: appState.medialList[0].sourceUrl,
                      placeholder: (context, url) => Image.asset(
                        'asset/Icon/placeholder.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover
                  ) : Image.asset(
                    'asset/Icon/placeholder.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  showMyPost() {

    if(model.showMyPostList.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          alignment: Alignment.center,
          child: Text("No Data Found"));
    } else {
      return  ListView.builder(
          itemCount: model.showMyPostList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return showView(index);
          });
    }
  }

  showView(int index) {
    if(model.showMyPostList[index].parentPost != null) {
      return sharingViewShow(index);
    } else {
      return postView(index);
    }
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
                    )
                  ],
                ),
              ), //appState.currentUserData

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: model.showMyPostList[index].content != null && model.showMyPostList[index].content.isNotEmpty ?
                  Text(model.showMyPostList[index].content, style: TextStyle(), textAlign: TextAlign.left ) : Container()),

              Container(
                height: MediaQuery.of(context).size.height  - 400,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: PageView.builder(
                    itemCount: model.showMyPostList[index].media.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index1) {
                      return model.showMyPostList[index].media != null && model.showMyPostList[index].media[index1].isNotEmpty
                          ? CachedNetworkImage(
                          imageUrl: model.showMyPostList[index].media[index1],
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
              Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.showMyPostList[index].id),
                    likeCommentShare("Comment",2, model.showMyPostList[index].id),
                    likeCommentShare("Share",3, model.showMyPostList[index].id),
                  ],
                ),
              )
            ],
          ),
        ),

        postIdStr == model.showMyPostList[index].id ? Container(
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


  sharingViewShow(int index) {
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
                    )
                  ],
                ),
              ), //appState.currentUserData

              Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Text(model.showMyPostList[index].content)),

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
                        child: Text(model.showMyPostList[index].parentPost.userName ?? "")),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                        child: model.showMyPostList[index].parentPost.content != null && model.showMyPostList[index].parentPost.content.isNotEmpty ?
                        Text(model.showMyPostList[index].parentPost.content, style: TextStyle(), textAlign: TextAlign.left ) : Container()),
                    Container(
                      height: MediaQuery.of(context).size.height  - 400,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: PageView.builder(
                          itemCount: model.showMyPostList[index].parentPost.media.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            return model.showMyPostList[index].parentPost.media != null && model.showMyPostList[index].parentPost.media[index1].isNotEmpty
                                ? CachedNetworkImage(
                                imageUrl: model.showMyPostList[index].parentPost.media[index1],
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

              Container(height: 50, color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    likeCommentShare("Like",1, model.showMyPostList[index].parentPost.id),
                    likeCommentShare("Comment",2, model.showMyPostList[index].parentPost.id),
                    likeCommentShare("Share",3, model.showMyPostList[index].parentPost.id),
                  ],
                ),
              )
            ],
          ),
        ),

        postIdStr == model.showMyPostList[index].id ? Container(
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
    return  Row(
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
                image: NetworkImage(model.showMyPostList[index].thumb)),
          ),
        ),
        SizedBox(width: 8),
        Text(model.showMyPostList[index].userName , overflow: TextOverflow.ellipsis, maxLines: 1),
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
          isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isShare: true, postId: postId)));
          if (isRef) {
            // model.showPostApi();
          }
        }
      },
      child: Text(title),
    );
  }

}
