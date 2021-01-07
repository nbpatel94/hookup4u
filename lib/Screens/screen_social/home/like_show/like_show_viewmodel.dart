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

       if(likeData.code == 200 && likeData.status == "success") {

         if(likeData.data.like != null) {
           likeList.addAll(likeData.data.like);
           lengthShow = lengthShow + 1;
           showIndexWise.add(0);
         }
         if(likeData.data.love != null) {
           loveList.addAll(likeData.data.love);
           lengthShow = lengthShow + 1;
           showIndexWise.add(1);
         }
         if(likeData.data.care != null) {
           careList.addAll(likeData.data.care);
           lengthShow = lengthShow + 1;
           showIndexWise.add(2);
         }
         if(likeData.data.haha != null) {
           hahaList.addAll(likeData.data.haha);
           lengthShow = lengthShow + 1;
           showIndexWise.add(3);
         }
         if(likeData.data.angry != null) {
           angryList.addAll(likeData.data.angry);
           lengthShow = lengthShow + 1;
           showIndexWise.add(4);
         }
         if(likeData.data.sad != null) {
           sadList.addAll(likeData.data.sad);
           lengthShow = lengthShow + 1;
           showIndexWise.add(5);
         }

         if(showIndexWise != null && showIndexWise.length != 0) {
           state.currentIndex = showIndexWise[0];
         }
         state.setState(() {});
         print(likeData);

       } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }




    });
  }

}