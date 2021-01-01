
import 'dart:convert';

import 'package:hookup4u/Screens/screen_social/home/home_screen.dart';
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
    
    SocialRestApi.showPostData().then((value) {

      SocialPostShowModel socialPostShowModel = SocialPostShowModel.fromJson(jsonDecode(value.body));

      print(socialPostShowModel);

      if(value != null) {
        if(socialPostShowModel.code == 200 && socialPostShowModel.status == "success") {
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

    SocialRestApi.deletePostData(userId).then((value) {
      // Map message = jsonDecode(value);
      showPostApi();
   /*   if(value != null) {
        print("Reponse Data $value");
      } else {
        print("empty data");
      }*/
      // socialPostShowModel.addAll(value);
    });
  }

}