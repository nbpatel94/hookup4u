import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/search_view/search_viewmodel.dart';
import 'package:hookup4u/Screens/screen_social/user_profile_view/user_profile_screen.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {

  TextEditingController searchFiled = TextEditingController();

  // bool isShowFollowUnFollow = false;

  final focus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyBoardHide();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  keyBoardHide(){
    Future.delayed(Duration(seconds: 1), () {
      FocusScope.of(context).requestFocus(focus);
    });
  }


  SearchViewModel model;

  @override
  Widget build(BuildContext context) {
    model ?? (model = SearchViewModel(this));

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, model.isChangesThisScreen);
        return false;
      },
      child: Scaffold(
          backgroundColor: ColorRes.primaryColor,
          body: SafeArea(
            child: Column(
              children: [
                headerView(),
                searchFiled.text.isNotEmpty ? searchDataView() : Container(),
                searchFiled.text.isNotEmpty ? Container() : recentView()
              ],
            ),
          ),
      ),
    );
  }

  headerView() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkResponse(
            onTap: () {
              Navigator.pop(context, model.isChangesThisScreen);
            },
            child: Container(
              child: Icon(Icons.close, color: ColorRes.white, size: 30),
            ),
          ),
          SizedBox(height: 10),
          Text("Search", style: TextStyle(color: ColorRes.white, fontSize: 35)),
          SizedBox(height: 10),
          Container(
            // margin: EdgeInsets.only(left: 15, right: 15),
              width: Utils().getDeviceWidth(context),
              height: 45,
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
                  model.searchListApi(value);
                  FocusScope.of(context).unfocus();

                },
                onChanged: (value) {
                   print(value.length);
                  if(value == null || value.length == 0) {
                    model.searchResponseModel.data = List();
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
          SizedBox(height: 35),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent search", style: TextStyle(color: ColorRes.white, fontSize: 20)),
              model?.searchRecentResponseModel?.data == null || model?.searchRecentResponseModel?.data?.length == 0  ? Container() : InkWell(
                  onTap: () {
                    model.userRecentHistoryDelete();
                  },
                  child: Text("Clear all", style: TextStyle(color: ColorRes.primaryRed))),
            ],
          )

        ],
      ),
    );
  }

  searchDataView() {

    if(model.searchDataShowMessage) {
      return Container();
    } else {
      return Expanded(
        child: model.searchResponseModel?.data != null && model.searchResponseModel.data.isNotEmpty
            ? ListView.builder(
            itemCount: model.searchResponseModel.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkResponse(
                    onTap: () async {
                      final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                          userId: model.searchResponseModel.data[index].userId,
                          isFollow: model.searchResponseModel.data[index].following)));
                      if (data == true) {
                        model.searchListApi(searchFiled.text);
                      }
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
                                    child: model.searchResponseModel.data[index]
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
                                        : Image.asset(
                                        'asset/Icon/placeholder.png',
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
                                    Text(
                                        model
                                            .searchResponseModel.data[index].name,
                                        style: TextStyle(color: ColorRes.white)),
                                    Text("3 Friends",
                                        style: TextStyle(color: ColorRes.greyBg)),
                                  ],
                                ),
                              ],
                            ),
                            InkResponse(
                              onTap: () {
                                model.userFollowApi(model.searchResponseModel.data[index].userId.toString(), true);
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorRes.primaryRed,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    model.searchResponseModel.data[index]
                                        .following
                                        ? "UnFollow"
                                        : "Follow",
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
            : Center(
          child: Container(
            child: Text("Search data not found",
                style: TextStyle(color: ColorRes.white)),
          ),
        ),
      );
    }
  }



  recentView() {

    if(model.recentDataShowMessage) {
      return Container();
    } else {
      return Expanded(
        child: model.searchRecentResponseModel?.data != null &&
            model.searchRecentResponseModel.data.isNotEmpty
            ? ListView.builder(
            itemCount: model.searchRecentResponseModel.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkResponse(
                    onTap: () async {
                      final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(
                          userId: model.searchRecentResponseModel.data[index].userId,
                          isFollow: model.searchRecentResponseModel.data[index].following)));
                      if (data == true) {
                        model.searchListApi(searchFiled.text);
                      }
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
                                    child: model.searchRecentResponseModel.data[index].thumb != null &&
                                        model.searchRecentResponseModel.data[index].thumb.isNotEmpty
                                        ? CachedNetworkImage(
                                        imageUrl: model.searchRecentResponseModel.data[index].thumb,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                'asset/Icon/placeholder.png',
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fill)
                                        : Image.asset(
                                        'asset/Icon/placeholder.png',
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
                                    Text(
                                        model.searchRecentResponseModel.data[index].name,
                                        style: TextStyle(color: ColorRes.white)),
                                    Text("3 Friends",
                                        style: TextStyle(color: ColorRes.greyBg)),
                                  ],
                                ),
                              ],
                            ),
                            InkResponse(
                              onTap: () {
                                model.userFollowApi(model.searchRecentResponseModel.data[index].userId.toString(), false);
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorRes.primaryRed,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    model.searchRecentResponseModel.data[index].following
                                        ? "UnFollow"
                                        : "Follow",
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
                ],
              );
            })
            : Center(
          child: Container(
            child: Text("Recent record empty",
                style: TextStyle(color: ColorRes.white)),
          ),
        ),
      );
    }
  }
}
