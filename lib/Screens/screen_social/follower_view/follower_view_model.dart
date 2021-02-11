import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/follower_following_model.dart';
import 'package:hookup4u/models/user_profile_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

import 'follower_screen.dart';

class FollowerFollowingViewModel {

  FollowerFollowingListState state;

  FollowerFollowingViewModel(this.state) {
    this.state = state;
    followerFollowingListApi();
  }

  bool isEmptyMessageShow = false;
  List<Follower> followerList= [];
  List<Following> followingList= [];

  bool followingScreenMessage = true;
  bool followerScreenMessage = true;

  followerFollowingListApi() {

    EasyLoading.show();
    SocialRestApi.getFollowerFollowingList().then((value) {

      if(value != null && value.statusCode == 200) {

        Map<String, dynamic> data = json.decode(value.body);

        if(data != null && data['code'] == 200 && data['status'] == "success") {

          FollowerFollowingModel followerFollowingModel = FollowerFollowingModel.fromJson(data);
          print(followerFollowingModel);

          followerList= [];
          followingList= [];
          followingScreenMessage = false;
          followerScreenMessage = false;
          followerFollowingModel.data.follower.forEach((element) {
            followerList.add(element);
          });

          followerFollowingModel.data.following.forEach((element) {
            followingList.add(element);
          });

          state.setState(() { });

        } else if(data != null && data['status'] == "error") {
          Utils().showToast(data['message']);
        } else {
          Utils().showToast("something wrong");
        }


        isEmptyMessageShow = true;
        state.setState(() {});
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
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
        // state.isShowFollowUnFollow = !state.isShowFollowUnFollow;

        // searchResponseModel
        // searchListApi(state.searchFiled.text);
        followerFollowingListApi();
        state.setState(() {});
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }


}