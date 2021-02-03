
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/user_profile_view/user_profile_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/search_response_model.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/models/user_profile_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

class UserProfileViewModel {

  UserProfilePageState state;
  bool isEmptyMessageShow = false;


  int totalFollowing = 0;

  UserProfileModel userProfileModel = UserProfileModel();
  // SocialPostShowModel socialPostShowModel = SocialPostShowModel();

  UserProfileViewModel(UserProfilePageState state) {
    this.state = state;
    userShowApi();
    // socialPostShowModel.data = List();
  }


  userShowApi() {
    EasyLoading.show();
    SocialRestApi.getUserProfileApi(state.widget.userId.toString()).then((value) {

      if(value != null && value.statusCode == 200) {
        // imagesList.add(value.sourceUrl.toString());
        userProfileModel = UserProfileModel.fromJson(jsonDecode(value.body));

        totalFollowing = userProfileModel.data.following;
        isEmptyMessageShow = true;
     /*   userProfileModel.data.userPosts.forEach((element) {
          socialPostShowModel.data.add(SocialPostShowData.fromUserPosts(element));
        });*/

        state.setState(() {});
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
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
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);
        // showMyPostApi();
        state.setState(() {});
      } else if(message['status'] == "error"){
        // Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }


  userFollowApi(String userId) {

    print("Hello $userId");
    EasyLoading.show();
    // String imageJoint = imagesList.join(",");

    SocialRestApi.postUserFollowApi(userId).then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);
        // showMyPostApi();
        state.isShowFollowUnFollow = !state.isShowFollowUnFollow;
        if(state.isShowFollowUnFollow) {
            //+1
          totalFollowing = totalFollowing + 1;
        } else {
            //-1
          totalFollowing = totalFollowing - 1;
        }
        state.setState(() {});
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

  friendRequestApi() {
    print("friend_id ${state.widget.userId}");
    print("friend_id ${appState.currentUserData.data.id}");
    EasyLoading.show();
    // String imageJoint = imagesList.join(",");
    Map<String, dynamic> friendRequestMap = {
      "initiator_id" : appState.currentUserData.data.id.toString(),
      "friend_id" : state.widget.userId.toString()
    };
    SocialRestApi.postFriendRequest(friendRequestMap).then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        state.setState(() {});
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

  deletePostApi(String userId) {
    EasyLoading.show();
    SocialRestApi.deletePostData(userId).then((value) {
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        Utils().showToast(message['message']);
        userShowApi();
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

}