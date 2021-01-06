
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/home_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

class SocialHomeViewModel {

  List<SocialPostShowData> socialPostShowList = List();
  SocialHomePageState state;

  SocialHomeViewModel(this.state){
    showPostApi();
  }


  showPostApi() {
    EasyLoading.show();
    SocialRestApi.showPostData().then((value) {
      SocialPostShowModel socialPostShowModel = SocialPostShowModel.fromJson(jsonDecode(value.body));
      print(socialPostShowModel);
      if(value != null) {
        if(socialPostShowModel.code == 200 && socialPostShowModel.status == "success") {
          state.isRef = false;
          socialPostShowList = List();
          socialPostShowModel.data.forEach((element) {
            socialPostShowList.add(element);
          });
          state.setState(() {});
        }
      } else if(socialPostShowModel.code == 200 && socialPostShowModel.status == "error"){
        print("socialPostShowModel.status");
        Utils().showToast(socialPostShowModel.message);
      } else {
        print("empty data");
      }
      // socialPostShowModel.addAll(value);
    });
  }

  deletePostApi(String userId) {
   EasyLoading.show();
    SocialRestApi.deletePostData(userId).then((value) {
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        Utils().showToast(message['message']);
        showPostApi();
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }


  addLikeApi(String postId, String type) {

    EasyLoading.show();
    // String imageJoint = imagesList.join(",");
    // print(imageJoint);
    Map<String, dynamic> postData = {
      "post_id": postId,
      "user_id": appState.currentUserData.data.id,
      "like_data": type,
    };
    print(postData);
    SocialRestApi.addLikePost(postData).then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);
        showPostApi();
        state.setState(() {});
      } else if(message['status'] == "error"){
        // Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

}