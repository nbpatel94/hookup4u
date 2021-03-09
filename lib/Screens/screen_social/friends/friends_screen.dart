import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

import 'friends_viewmodel.dart';

class FriendsScreen extends StatefulWidget {
  @override
  FriendsScreenState createState() => FriendsScreenState();
}

class FriendsScreenState extends State<FriendsScreen> {

  final focus = FocusNode();
  TextEditingController searchFiled = TextEditingController();
  FriendsViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model ?? (model = FriendsViewModel(this));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.person_add_alt_1, color: Colors.white, size: 20)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Friends", style: TextStyle(color: ColorRes.white, fontSize: 30))),
              SizedBox(height: 10),
              Container(
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
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Connect to find more friends", style: TextStyle(color: ColorRes.white, fontSize: 30))),
              SizedBox(height: 5),
              Container(
                height: 125,
                margin: EdgeInsets.only(left: 10),
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return InkResponse(
                      onTap: () {
                        // faceBookButton();
                        model.loginWithFB();
                      },
                      child: Container(
                        height: 100,
                        width: 130,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Expanded(child: Icon(Icons.add)),
                            SizedBox(
                                height: 25,
                                child: Text("Facebook", style: TextStyle(color: ColorRes.white, fontSize: 15))),
                            SizedBox(
                                height: 25,
                                child: Text("connect", style: TextStyle(color: ColorRes.white, fontSize: 15))),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                    );
                }),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Suggestions", style: TextStyle(color: ColorRes.white, fontSize: 20)),
                    Text("Follow all", style: TextStyle(color: ColorRes.primaryRed, fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              recentView()
            ],
          ),
        ),
      ),
    );
  }


  Widget faceBookButton() {
    return GestureDetector(
      //child: GestureDetector(
      onTap: () {
        //faceBookLogin();
      },
      child: Container(
        // height:70,
        margin: EdgeInsets.only(top: 10),
        child: Icon(Icons.face),
      ),
      // ),
    );
  }

  recentView() {
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
                                       "Follow",
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
