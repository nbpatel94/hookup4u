import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/home/tab3/message_user_list/chat_screen.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/search_response_model.dart';
import 'package:hookup4u/models/thread_data_model.dart';
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import '../../../../../app.dart';
import 'new_user_get_screen.dart';

class NewUserGetViewModel {

  bool searchDataShowMessage = false;
  SearchResponseModel searchResponseModel;
  List<MatchModel> matchList = [];
  ThreadDataModel threadDataModel;
  // SearchResponseModel searchRecentResponseModel;
  MessageElement messageElement;

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


  existingThreadMessage(String threadId) {

    EasyLoading.show();
    RestApi.getThreadIdWiseApi(threadId).then((response) {
      // state.isLoading = false;
      // state.setState(() {});
      EasyLoading.dismiss();

      if(response != null && response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        threadDataModel = ThreadDataModel.fromJson(json.decode(response.body));
        Navigator.push(state.context, MaterialPageRoute (builder: (_) => SocialChatScreen(threadAllData: threadDataModel.data[0])));
        state.setState(() {});
      } else {
        print("something wrong");
        Utils().showToast("Something wrong");
      }
    });

    /*   if(res=='Yes') {
      state.setState(() {
        state.isLoading = true;
      });
      // model.getMyMatch();
    }*/

  }

  createThreadMessage(String userId, String threadId) async {

    String message  = "Hello";
    // String message  = state.searchFiled.text;
    print("Sending First Message");
    EasyLoading.show();

    // String threadId = await RestApi.createThreadMessage(state.widget.userId, message,state.widget.matchId);
    // state.widget.threadId = threadId;
    // temp.threadId = int.parse(state.widget.threadId);

    // if (!state.mounted) return;
    // state.setState(() {
    //   messageElement = MessageElement();
    //   messageElement.messages = [];
    //   messageElement.messages.insert(0,temp);
    // });

    print("Sending First Message");

    RestApi.socialCreateThreadMessage(userId, message).then((response) {
      EasyLoading.dismiss();
      if(response != null && response.statusCode == 200 || response.statusCode == 201) {
        String threadId =  jsonDecode(response.body)[0]['id'].toString();
        print(threadId);
        existingThreadMessage(threadId);
      } else {
        print("Some thing wrong..");
        Utils().showToast("Something wrong.");
      }
    });

    threadId = threadId;
    // temp.threadId = int.parse(threadId);
    // await databaseHelper.insert(temp);


    // ThreadModel temp = ThreadModel(senderId: appState.id,message: MessageMessage(raw: message),dateSent: DateTime.now());
    // if(threadId != null) {
    //   if (!state.mounted) return;
    //   state.setState(() {
    //     messageElement.messages.insert(0,temp);
    //   });
    //   temp.threadId = int.parse(threadId);
    //   await databaseHelper.insert(temp);
    //   print("Sending Message");
    //   await RestApi.sendThreadMessage(userId, message, threadId);
    // } else {
    //   if (!state.mounted) return;
    //   state.setState(() {
    //     messageElement = MessageElement();
    //     messageElement.messages = [];
    //     messageElement.messages.insert(0,temp);
    //   });
    //   print("Sending First Message");
    //   String threadId = await RestApi.socialCreateThreadMessage(userId, message);
    //   threadId = threadId;
    //   temp.threadId = int.parse(threadId);
    //   await databaseHelper.insert(temp);
    // }
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