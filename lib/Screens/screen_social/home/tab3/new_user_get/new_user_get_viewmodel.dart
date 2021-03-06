import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/search_response_model.dart';
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import '../../../../../app.dart';
import 'new_user_get_screen.dart';

class NewUserGetViewModel {

  bool searchDataShowMessage = false;
  SearchResponseModel searchResponseModel;

  // SearchResponseModel searchRecentResponseModel;

  NewUserListPageState state;

  NewUserGetViewModel(NewUserListPageState state) {
    this.state = state;
  }

  searchListApi(String searchTile) {
    EasyLoading.show();
    SocialRestApi.searchFriendListApi(searchTile).then((value) {
      searchDataShowMessage = false;
      if(value != null && value.statusCode == 200) {
        // imagesList.add(value.sourceUrl.toString());
        searchResponseModel = SearchResponseModel.fromJson(jsonDecode(value.body));
        state.setState(() {});
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
    });
  }


  createThreadMessage(String friendId) async {

    String message  = state.searchFiled.text;



    /*ThreadModel temp = ThreadModel(senderId: appState.id,message: MessageMessage(raw: message),dateSent: DateTime.now());
    if(state.widget.threadId != null) {
      if (!state.mounted) return;
      state.setState(() {
        messageElement.messages.insert(0,temp);
      });
      temp.threadId = int.parse(state.widget.threadId);
      await databaseHelper.insert(temp);
      print("Sending Message");
      await RestApi.sendThreadMessage(state.widget.userId, message,state.widget.threadId);
    } else {
      if (!state.mounted) return;
      state.setState(() {
        messageElement = MessageElement();
        messageElement.messages = [];
        messageElement.messages.insert(0,temp);
      });
      print("Sending First Message");
      String threadId = await RestApi.createThreadMessage(state.widget.userId, message,state.widget.matchId);
      state.widget.threadId = threadId;
      temp.threadId = int.parse(state.widget.threadId);
      await databaseHelper.insert(temp);
    }*/
  }


/*  userRecentHistory() {
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
  }*/


}