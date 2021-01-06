import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/like_show_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

import 'like_show_screen.dart';

class LikeShowViewModel {

  LikeShowScreenState state;

  List<LikeData> likeList = [];
  List<LikeData> loveList = [];
  List<LikeData> careList = [];
  List<LikeData> hahaList = [];
  List<LikeData> angryList = [];
  List<LikeData> sadList = [];
  int lengthShow = 0;
  List<int> showIndexWise = [];

  LikeShowViewModel(this.state) {
    showLikeApi();
  }


  showLikeApi() {

    EasyLoading.show();


    SocialRestApi.showLikeData(state.widget.postId).then((value) {
      print(value);

      likeList = [];
      loveList = [];
      careList = [];
      hahaList = [];
      angryList = [];
      sadList = [];
      showIndexWise = [];
      Map<String, dynamic> message = jsonDecode(value.body);

      SocialPostView likeData = socialPostViewFromJson(value.body);

      if(likeData.like != null) {
        likeList.addAll(likeData.like);
        lengthShow = lengthShow + 1;
        showIndexWise.add(0);
      }
      if(likeData.love != null) {
        loveList.addAll(likeData.love);
        lengthShow = lengthShow + 1;
        showIndexWise.add(1);
      }
      if(likeData.care != null) {
        careList.addAll(likeData.care);
        lengthShow = lengthShow + 1;
        showIndexWise.add(2);
      }
      if(likeData.haha != null) {
        hahaList.addAll(likeData.haha);
        lengthShow = lengthShow + 1;
        showIndexWise.add(3);
      }
      if(likeData.angry != null) {
        angryList.addAll(likeData.angry);
        lengthShow = lengthShow + 1;
        showIndexWise.add(4);
      }
      if(likeData.sad != null) {
        sadList.addAll(likeData.sad);
        lengthShow = lengthShow + 1;
        showIndexWise.add(5);
      }

      if(showIndexWise != null && showIndexWise.length != 0) {
        state.currentIndex = showIndexWise[0];
      }
      state.setState(() {});
      print(likeData);

 /*     if(message['code'] == 200 && message['status'] == "success") {
        // Utils().showToast(message['message']);
        // showPostApi();
        state.setState(() {});
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }*/
    });
  }

}