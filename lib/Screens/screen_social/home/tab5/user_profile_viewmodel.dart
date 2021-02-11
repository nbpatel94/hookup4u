import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/home/tab5/user_profile_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/models/user_media_profile.dart';
import 'package:hookup4u/models/user_profile_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

class UserProfileViewModel {

  UserProfileModel userProfileModel;
  int totalFollowing = 0;

  List<SocialPostShowData> showMyPostList = List();
  bool isEmptyMessageShow = false;
  bool isEmptyMessageUserMedia = false;

  // List<SocialPostShowData> socialPostShowList = List();
  UserMediaProfileApi userMediaProfileApi;

  UserProfileScreenState state;
  UserProfileViewModel(this.state) {
    userShowApi();
    showMyPostApi();
    userMediaShow();
  }


  userShowApi() {
    EasyLoading.show();
    SocialRestApi.getUserProfileApi(appState.currentUserData.data.id.toString()).then((value) {

      if(value != null && value.statusCode == 200) {
        // imagesList.add(value.sourceUrl.toString());
        userProfileModel = UserProfileModel.fromJson(jsonDecode(value.body));

        totalFollowing = userProfileModel.data.following;
        // isEmptyMessageShow = true;

        state.setState(() {});
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
    });
  }

  showMyPostApi() {
    EasyLoading.show();
    SocialRestApi.showMyPostData().then((value) {
      SocialPostShowModel socialPostShowModel = SocialPostShowModel.fromJson(jsonDecode(value.body));
      print(socialPostShowModel);
      if(value != null) {
        if(socialPostShowModel.code == 200 && socialPostShowModel.status == "success") {
          state.isRef = false;
          showMyPostList = List();
          isEmptyMessageShow = true;
          socialPostShowModel.data.forEach((element) {
            showMyPostList.add(element);
          });
          if (state.mounted) {
            state.setState(() {
              // Your state change code goes here
            });
          }}
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
        showMyPostApi();
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
      /*   if(value != null) {
        print("Reponse Data $value");
      } else {
        print("empty data");
      }*/
      // socialPostShowModel.addAll(value);
    });
  }

  addLikeApi(String postId, String type) {

    print("Hello $postId");
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
      isEmptyMessageUserMedia = true;
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);
        showMyPostApi();
        state.setState(() {});
      } else if(message['status'] == "error"){
        // Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }


  userMediaShow() {
    SocialRestApi.getUserProfileMedia().then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);

        userMediaProfileApi = UserMediaProfileApi.fromJson(message);

        state.setState(() {});
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

}