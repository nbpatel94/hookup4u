import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/edit/edit_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/post_data/post_data_screen.dart';

import 'home_viewmodel.dart';

class SocialHomePage extends StatefulWidget {
  @override
  SocialHomePageState createState() => SocialHomePageState();
}

class SocialHomePageState extends State<SocialHomePage> {

  bool isRef = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  SocialHomeViewModel model;
  
  @override
  Widget build(BuildContext context) {
    model ?? (model = SocialHomeViewModel(this));
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
              headerView(),
              showUserData()
          ],
        ),
      ),
    );
  }

  headerView() {
    return InkResponse(
      onTap: () async {
        isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isShare: false, postId: "")));
        if(isRef) {
          model.showPostApi();
        }},
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(50)
          ),
      child: Text("What's on your mind?"),
        /*      child: TextField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: ""
            ),
          )*/
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
    return   model.socialPostShowList[index].parentPost != null ? sharingViewShow(index)  : Container(
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

                Text(model.socialPostShowList[index].userName),

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
                     Text(model.socialPostShowList[index].content, style: TextStyle(), textAlign: TextAlign.left ) : Container()),

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
          Container(height: 50, color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                likeCommentShare("Like",1),
                likeCommentShare("Comment",2),
                likeCommentShare("Share",3, postId: model.socialPostShowList[index].id),
              ],
            ),
          )
        ],
      ),
    );
    // : Container(height: 50, width: 150, child: Text("hello"));
  }


  likeCommentShare(String title, int index, {String postId}) {
    return InkResponse(
      onTap: () async {
        if (index == 1) {

        } else if(index == 2) {

        } else if(index == 3){
          isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen(isShare: true, postId: postId)));
          if (isRef) {
            model.showPostApi();
          }
        }
      },
      child: Text(title),
    );
  }


  sharingViewShow(int index, ) {
    return Container(
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

                Text(model.socialPostShowList[index].userName + "   Share Post"),
                Row(
                  children: [
                    InkResponse(
                        onTap: () {
                          // model.deletePostApi(model.socialPostShowList[index].id);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataScreen(socialPostShowData: model.socialPostShowList[index])));
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

          Container(height: 50, color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Like"),
                Text("Comment"),
                Text("Share"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
