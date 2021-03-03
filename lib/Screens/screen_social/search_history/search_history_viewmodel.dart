import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/search_history/search_history.dart';
import 'package:hookup4u/models/search_response_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';

class SearchHistoryViewModel {

  bool recentDataShowMessage = true;
  SearchResponseModel searchRecentResponseModel;

  SearchHistoryPageState state;
  SearchHistoryViewModel(SearchHistoryPageState state) {
    this.state = state;
    userRecentHistory();
  }

  userRecentHistory() {
    EasyLoading.show();
    SocialRestApi.getRecentUserList().then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(value != null && message['code'] == 200 && message['status'] == "success") {
        recentDataShowMessage = false;
        // searchListApi(state.searchFiled.text);
        // searchRecentResponseModel = SearchResponseModel();
        searchRecentResponseModel = SearchResponseModel.fromJson(message);
        state.setState(() {});
      } else if(message['status'] == "error") {
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

}