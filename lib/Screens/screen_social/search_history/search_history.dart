import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/search_history/search_history_viewmodel.dart';
import 'package:hookup4u/Screens/screen_social/user_profile_view/user_profile_screen.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  SearchHistoryPageState createState() => SearchHistoryPageState();
}

class SearchHistoryPageState extends State<SearchHistoryPage> {

  SearchHistoryViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = SearchHistoryViewModel(this));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("Search History", style: TextStyle(color: ColorRes.white, fontSize: 33))
          ),

          recentView()

        ],
      ),
    );
  }


  recentView() {

    if(model.recentDataShowMessage) {
      return Container();
    } else {
      return Expanded (
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
                        // model.searchListApi(searchFiled.text);
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
                          /*  InkResponse(
                              onTap: () {
                                // model.userFollowApi(model.searchRecentResponseModel.data[index].userId.toString(), false);
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
                            )*/
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
