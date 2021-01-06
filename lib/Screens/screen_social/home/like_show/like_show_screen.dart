import 'package:flutter/material.dart';
import 'package:hookup4u/models/like_show_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

import 'like_show_viewmodel.dart';

class LikeShowScreen extends StatefulWidget {

  final String postId;
  const LikeShowScreen({Key key, this.postId}) : super(key: key);

  @override
  LikeShowScreenState createState() => LikeShowScreenState();
}

class LikeShowScreenState extends State<LikeShowScreen> {


  List<String> emojis = ["👍","❤️","😘","🤣","😡","😥"];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  LikeShowViewModel model;
  @override
  Widget build(BuildContext context) {

    model ?? (model = (LikeShowViewModel(this)));

    return Scaffold(
      appBar: AppBar(
        title: Text("People who reacted"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            model.showLikeApi();
          })
        ],
      ),
        body: Column(
          children: [
            Container(
                height: 50,
                color: ColorRes.primaryColor,
                child: ListView.builder(
                    itemCount: model.lengthShow,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkResponse(
                        onTap: () {
                          currentIndex = model.showIndexWise[index];
                          setState(() {});
                        },
                        child: Container(
                            height: 35,
                            width: 60,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            // child: showEmojisData(),
                            child: Text(showEmojisData(model.showIndexWise[index]), style: TextStyle(fontSize: 30))
                        ),
                      );
                    })),
            Expanded(
                child: ListView.builder(
                itemCount: showListOfUserLength(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index1) {

                  /*if(model.showIndexWise != null && model.showIndexWise.length != 0) {
                    currentIndex = model.showIndexWise[index1];
                  }*/

                  return showListOfUser(index1);
                  // return Text("Hello world", style: TextStyle(fontSize: 30));
                })
            )
          ],
        ),
    );
  }

  showListOfUserLength() {

    if(currentIndex == 0) {
      if(model.likeList != null && model.likeList.length != 0) {
        return model.likeList.length;
      }
    } else if(currentIndex == 1) {
      if(model.loveList != null && model.loveList.length != 0) {
        return model.loveList.length;
      }
    } else if(currentIndex == 2) {
      if(model.careList != null && model.careList.length != 0) {
        return model.careList.length;
      }
    } else if(currentIndex == 3) {
      if(model.hahaList != null && model.hahaList.length != 0) {
        return model.hahaList.length;
      }
    } else if(currentIndex == 4) {
      if(model.angryList != null && model.angryList.length != 0) {
        return model.angryList.length;
      }
    } else if(currentIndex == 5) {
      if(model.sadList != null && model.sadList.length != 0) {
        return model.sadList.length;
      }
    }
  }

  showListOfUser(int index) {

    if(currentIndex == 0) {
      if(model.likeList != null && model.likeList.length != 0) {
        return userNameView(index, model.likeList[index]);
        // return Text(model.likeList[index].userName);
      }
    } else if(currentIndex == 1) {
      if(model.loveList != null && model.loveList.length != 0) {
        return userNameView(index, model.loveList[index]);
        // return Text(model.loveList[index].userName);
      }
    } else if(currentIndex == 2){
      if(model.careList != null && model.careList.length != 0) {
        return userNameView(index, model.careList[index]);
        // return Text(model.careList[index].userName);
      }
    } else if(currentIndex == 3) {

      if(model.hahaList != null && model.hahaList.length != 0) {
        return userNameView(index, model.hahaList[index]);
        // return Text(model.hahaList[index].userName);
      }
    } else if(currentIndex == 4) {
      if(model.angryList != null && model.angryList.length != 0) {
        return userNameView(index, model.angryList[index]);
        return Text(model.angryList[index].userName);
      }
    } else if(currentIndex == 5) {
      if(model.sadList != null && model.sadList.length != 0) {
        return userNameView(index, model.sadList[index]);
        // return Text(model.careList[index].userName);
      }
    }
  }

  showEmojisData(int index) {
    if (model.likeList != null && model.likeList.length != 0) {
      if (index == 0) {
        return "👍";
      }
    }
    if (model.loveList != null && model.loveList.length != 0) {
      if (index == 1) {
        return "❤️";
      }
    }
    if (model.careList != null && model.careList.length != 0) {
      if (index == 2) {
        return "😘";
      }
    }

    if (model.hahaList != null && model.hahaList.length != 0) {
      if (index == 3) {
        return "🤣";
      }
    }
    if (model.angryList != null && model.angryList.length != 0) {
      if (index == 4) {
        return "😡";
      }
    }
    if (model.careList != null && model.sadList.length != 0) {
      if (index == 5) {
        return "😥";
      }
    } else {
      return "";
    }
  }

  userNameView(int index, LikeData listData) {
    return listData != null && listData.postId != null ? Container(
        height: 40,
        width: Utils().getDeviceWidth(context),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: ColorRes.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(listData.userName ?? "Empty", style: TextStyle(color: ColorRes.white))) :
    Center(child: Container(child: Text("No data found!")));
  }


}
