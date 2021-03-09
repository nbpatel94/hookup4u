import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/thread_data_model.dart';
import 'package:hookup4u/models/thread_list_model.dart' as thread;
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/utils.dart';

import 'messages_page.dart';

class SocialMessagesPageViewModel {

  SocialMessagesScreenState state;
  // List<MatchModel> matchList = [];
  List<Map> userAndThreadId = [];
  ThreadDataModel threadDataModel = ThreadDataModel();
  // List<thread.ThreadList> tempList = [];
  // List<String> friendIdList = [];

  List<Map> listMapData = [];

  SocialMessagesPageViewModel(this.state) {
    // getMyMatch();
    threadListShowApi();
  }

  getMyMatch() async {

    /*tempList = await RestApi.getThreadListApi();

    tempList.forEach((element) {

      String id = "";
      Map<String, dynamic> data = element.senderIds;
      print(data);
      data.entries.map((e) {
        print("hellio ${e.key}");
        if(e.key != appState.currentUserData.data.id.toString()) {
          id = e.key;
        }
        return e.key;
      }).toList();

      Map userMapa = {
        "friendId" : id,
        "threadId" : element.id
      };
      friendIdList.add(id);
      print("friend id length : ${friendIdList.length}");
      print(userMapa);
      userAndThreadId.add(userMapa);
    });*/


    // for(int i=0;i<tempList.length;i++){
    //   if(tempList[i].id != null) {
    //     tempList[i].lastMessage = await lastMessage(int.parse(tempList[i].threadId));
    //   }
    // }

    List<MatchModel> tempList = await RestApi.myMatchApi();

    // if(tempList.isNotEmpty) {
    //   tempList.removeWhere((element) => element.mutualMatch != 'true');
    // }

    for(int i=0;i<tempList.length;i++) {
      if(tempList[i].threadId != null) {
        tempList[i].lastMessage = await lastMessage(int.parse(tempList[i].threadId));
      }
    }

    // matchList = tempList;
    // print(matchList.length);

    if (!state.mounted) return;
    state.setState(() {
      state.isLoading = false;
    });
  }

  lastMessage(int th) async  {
    var las = await databaseHelper.getLastMessage(th);
    return las.isEmpty ? "" : las[0].message.raw;
  }


  threadListShowApi() {

    RestApi.getThreadListApi().then((response) {
      state.isLoading = false;
      state.setState(() {});
      if(response != null && response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        threadDataModel = ThreadDataModel.fromJson(json.decode(response.body));
        threadDataModel.data.forEach((element) {
          Map userData = {
            "userId": element.recipient,
            "threadId": element.threadId,
          };
          listMapData.add(userData);
        });
        state.setState(() {});
      } else {
        print("something wrong");
        Utils().showToast("Something wrong");
      }
    });
  }

}