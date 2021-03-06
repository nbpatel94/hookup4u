import 'package:flutter/material.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/thread_list_model.dart' as thread;
import 'package:hookup4u/restapi/restapi.dart';

import 'messages_page.dart';

class SocialMessagesPageViewModel {

  SocialMessagesScreenState state;
  List<MatchModel> matchList = [];
  List<Map> userAndThreadId = [];

  List<thread.ThreadList> tempList = [];
  List<String> friendIdList = [];

  SocialMessagesPageViewModel(this.state) {
    getMyMatch();
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

    for(int i=0;i<tempList.length;i++){
      if(tempList[i].threadId!=null) {
        tempList[i].lastMessage = await lastMessage(int.parse(tempList[i].threadId));
      }
    }

    matchList = tempList;
    print(matchList.length);

    if (!state.mounted) return;
    state.setState(() {
      state.isLoading = false;
    });
  }

  lastMessage(int th) async  {
    var las = await databaseHelper.getLastMessage(th);
    return las.isEmpty ? "" : las[0].message.raw;
  }

}