import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../prefrences.dart';
import 'notification_onoff_screen.dart';

class NotificationOnOffViewModel {

  NotificationOnOFFPageState state;

  NotificationOnOffViewModel(NotificationOnOFFPageState state) {

    this.state = state;

  }


  notificationTokenSend() async {

    // EasyLoading.show();
    EasyLoading.dismiss();

    // appState.jobTitle = jobTitleCont.text.trim();
    // appState.userDetailsModel.meta.jobTitle = jobTitleCont.text.trim();
    // appState.about = aboutCont.text.trim();
    // appState.userDetailsModel.meta.about = aboutCont.text.trim();
    // appState.livingIn = livingCont.text.trim();
    // appState.userDetailsModel.meta.livingIn = livingCont.text.trim();
    // appState.userDetailsModel.meta.children = appState.children;
    // appState.userDetailsModel.meta.relation = appState.relation;
    // appState.userDetailsModel.meta.deviceToken = "";


    String token = state.prefs.getString("token");

    if(state.getToken != null && state.getToken.isNotEmpty) {

      state.getToken = "";
      appState.userDetailsModel.meta.deviceToken = "";

    } else {

      state.getToken = token;
      appState.userDetailsModel.meta.deviceToken = token;

    }

    print(appState.userDetailsModel.meta.deviceToken);

    // print(appState.userDetailsModel.meta.toJson());
    // await sharedPreferences.setString(Preferences.metaData, jsonEncode(appState.userDetailsModel.meta.toJson()));

    RestApi.updateUserDetails(appState.userDetailsModel.meta.toRemoveToken()).then((value) {
      EasyLoading.dismiss();
      if (value == 'success') {
        // Navigator.pop(context);
      } else {
        Utils().showToast("Something went wrong! Try to update after sometime");
        // snackbarWithDismiss('Something went wrong! Try to update after sometime');
      }
    });


  }

}