import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/user_profile_view/user_profile_screen.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

import 'friends_request_viewmodel.dart';

class FriendsRequestPage extends StatefulWidget {
  @override
  FriendsRequestPageState createState() => FriendsRequestPageState();
}

class FriendsRequestPageState extends State<FriendsRequestPage> {

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  FriendRequestViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = FriendRequestViewModel(this));

    refreshList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  Future<Null> refreshList() async {

    model.friendRequestShow(false);
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 6));
    
    // setState(() {
    //   // model.showCommentApi();
    // });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        // actions: [
        //   Padding(
        //       padding: EdgeInsets.only(left: 10),
        //       child: Icon(Icons.person_add_alt_1, color: Colors.white, size: 20)
        //   )
        // ],
      ),
     body: RefreshIndicator(
       key: refreshKey,
       onRefresh: refreshList,
       child: ListView(
         children: [
           Padding(
               padding: EdgeInsets.only(left: 10),
               child: Text("Friends Request", style: TextStyle(color: ColorRes.white, fontSize: 20))),
           SizedBox(height: 10),
           followingView(),
           SizedBox(height: 10),
           Padding(
               padding: EdgeInsets.only(left: 10),
               child: Text("Friends Suggestion", style: TextStyle(color: ColorRes.white, fontSize: 20))),
           SizedBox(height: 10),
           friendSuggestion()
         ],
       ),
     ),
     /* body: SingleChildScrollView (
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding (
              //     padding: EdgeInsets.only(left: 10),
              //     child: Text(widget.isCheckScreen ?? "", style: TextStyle(color: ColorRes.white, fontSize: 30))),
              SizedBox (height: 10),
              *//*Container (
                // margin: EdgeInsets.only(left: 15, right: 15),
                  width: Utils().getDeviceWidth(context),
                  height: 45,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: ColorRes.greyBg.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    focusNode: focus,
                    controller: searchFiled,
                    onSubmitted: (value) {
                      print("search");
                      // model.searchListApi(value);
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      print(value.length);
                      if(value == null || value.length == 0) {
                        // model.searchResponseModel.data = List();
                        setState(() {});
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: ColorRes.white),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: ColorRes.greyBg)
                    ),
                  )),
              SizedBox (height: 25),
              Padding (
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Suggestions", style: TextStyle(color: ColorRes.white, fontSize: 20)),
                    Text("Follow all", style: TextStyle(color: ColorRes.primaryRed, fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 10),*//*
              // widget.isCheckScreen == "Following" ?  followingView() : Container(),

              followingView(),
              recentView()
            ],
          ),
        ),
      ),*/


    );
  }


  followingView() {

    if(model.isMessageShow) {
      return Container();
    } else {
      return Expanded(
          child: /*model.searchResponseModel?.data != null &&
          model.searchResponseModel.data.isNotEmpty
          ? */
          model.allFriendRequestShow != null && model.allFriendRequestShow.isNotEmpty ?
          ListView.builder(
              itemCount: model.allFriendRequestShow.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                        userId: int.parse(model.allFriendRequestShow[index].initiatorUserId),
                        isFollow: false,
                        isOpenRequestScreen: true,
                        // isFollow: model.allFriendRequestShow[index].following
                    )));
                    if (data == true) {
                      model.friendRequestShow(true);
                    }

                    // final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                    //     userId: int.parse(model.allFriendRequestShow[index].id),
                    //     isFollow: model.allFriendRequestShow[index].following)));
                    // if (data == true) {
                    //   model.followerFollowingListApi();
                    // }

                    // final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                    //     userId: model
                    //         .searchResponseModel.data[index].userId,
                    //     isFollow: model.searchResponseModel.data[index]
                    //         .following)));
                    // if (data == true) {
                    //   model.searchListApi(searchFiled.text);
                    // }

                  },
                  child: Column(
                    children: [

                      Container(
                        height: 70,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15, right: 15),
                        width: Utils().getDeviceWidth(context),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Row (
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Container (
                                    width: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(

                                        height: 55,
                                        width: 55,
                                        alignment: Alignment.center,
                                        color: ColorRes.white.withOpacity(0.5),

                                        child: model.allFriendRequestShow[index].thumb != null && model.allFriendRequestShow[index].thumb.isNotEmpty
                                            ? CachedNetworkImage(
                                            imageUrl: model.allFriendRequestShow[index].thumb,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'asset/Icon/placeholder.png',
                                                    height: 120,
                                                    width: 120,
                                                    fit: BoxFit.cover),
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.fill)
                                            : Image.asset('asset/Icon/placeholder.png',
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(model.allFriendRequestShow[index].initiatorName, style: TextStyle(color: ColorRes.white)),
                                      Text("3 Friends", style: TextStyle(color: ColorRes.greyBg)),
                                    ],
                                  ),

                                ],

                              ),

                              Container(
                                width: 150,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(onTap: () {
                                      model.acceptFriendRequestApi(model.allFriendRequestShow[index].initiatorUserId);
                                    }, child: Container(
                                      height: 25,
                                      width: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorRes.primaryRed,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text("Accept", style: TextStyle()))
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(onTap: () {
                                      model.deleteFriendsRequest(model.allFriendRequestShow[index].initiatorUserId);
                                    }, child: Container(
                                        height: 25,
                                        width: 60,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(color: ColorRes.white),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text("Delete", style: TextStyle(color: ColorRes.primaryRed))))
                                  ],
                                ),
                              )
                              // InkResponse(
                              //   onTap: () {
                              //     // model.userFollowApi(model.followingList[index].id.toString());
                              //   },
                              //   child: Container(
                              //     height: 30,
                              //     width: 100,
                              //     alignment: Alignment.center,
                              //     decoration: BoxDecoration(
                              //         color: model.followingList[index].following ? ColorRes.white : ColorRes.primaryRed,
                              //         borderRadius: BorderRadius.circular(10),
                              //         border: Border.all(color: model.followingList[index].following ? ColorRes.white : ColorRes.primaryRed, width: 1)
                              //     ),
                              //
                              //     child:  Text(
                              //         model.followingList[index].following ? "UnFollow" :
                              //         "Follow",
                              //         style: TextStyle(color: ColorRes.white , fontSize: 15),
                              //         // style: TextStyle(color: model.followingList[index].following ? ColorRes.primaryRed : ColorRes.white, fontSize: 15),
                              //         textAlign: TextAlign.center),
                              //
                              //   ),
                              // )
                            ]),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: Divider(color: ColorRes.black, height: 5))
                    ]
                    ,
                  ),
                );
              }) : Center(child: Container(child: Text("No Record Found")))
      );
    }
  }


  friendSuggestion() {
    return Expanded(
        child: /*model.searchResponseModel?.data != null &&
          model.searchResponseModel.data.isNotEmpty
          ? */
        ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkResponse(
                    onTap: () async {
                      // final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                      //     userId: model
                      //         .searchResponseModel.data[index].userId,
                      //     isFollow: model.searchResponseModel.data[index]
                      //         .following)));
                      // if (data == true) {
                      //   model.searchListApi(searchFiled.text);
                      // }
                    },
                    child: Container(
                      height: 70,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: Utils().getDeviceWidth(context),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    alignment: Alignment.center,
                                    color: ColorRes.white.withOpacity(0.5),
                                    // padding: EdgeInsets.all(1),
                                    child: /*model.searchResponseModel.data[index]
                                      .thumb !=
                                      null &&
                                      model.searchResponseModel.data[index]
                                          .thumb.isNotEmpty
                                      ? CachedNetworkImage(
                                      imageUrl: model.searchResponseModel
                                          .data[index].thumb,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              'asset/Icon/placeholder.png',
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.fill)
                                      : */
                                    Image.asset('asset/Icon/placeholder.png',
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Paul Gilbert",
                                        style: TextStyle(color: ColorRes.white)),
                                    Text("3 Friends",
                                        style: TextStyle(color: ColorRes.greyBg)),
                                  ],
                                ),
                              ],
                            ),
                            InkResponse(
                              onTap: () {
                                // model.userFollowApi(model
                                //     .searchResponseModel.data[index].userId
                                //     .toString());
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorRes.primaryRed,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  /* model.searchResponseModel.data[index]
                                      .following
                                      ? "UnFollow" :*/
                                    "Add Friend",
                                    style: TextStyle(
                                        color: ColorRes.white, fontSize: 15),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Divider(color: ColorRes.black, height: 5))
                ]
                ,
              );
            })
      /* : Center(
        child: Container(
          child: Text("No Data Avelible",
              style: TextStyle(color: ColorRes.white)),
        ),
      ),*/
    );
  }

}
