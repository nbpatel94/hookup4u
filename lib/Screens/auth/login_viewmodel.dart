import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'dart:convert';
import 'package:hookup4u/prefrences.dart';
import 'package:hookup4u/models/mediamodel.dart';

class LoginViewModel {

  LoginPageState state;
  LoginViewModel(this.state);

  login() async {
    String confirm = await RestApi.logInApi(state.usernameCont.text.trim(), state.passwordCont.text.trim(), state.context);
    if (confirm == 'success') {
      UserDetailsModel userDetailsModel = await RestApi.getSingleUserDetails(appState.id);
      if(userDetailsModel!=null && userDetailsModel.meta.about!=""){
        appState.userDetailsModel = userDetailsModel;
        appState.children = userDetailsModel.meta.children;
        appState.gender = userDetailsModel.meta.gender;
        appState.relation = userDetailsModel.meta.relation;
        appState.livingIn = userDetailsModel.meta.livingIn;
        appState.jobTitle = userDetailsModel.meta.jobTitle;
        appState.about = userDetailsModel.meta.about;

        appState.superLikeCount = userDetailsModel.meta.superLike;
        appState.likeCount = userDetailsModel.meta.likeCount;
        if(userDetailsModel.meta.likeTime!="") {
          appState.likeTime = DateTime.parse(userDetailsModel.meta.likeTime);
        } else {
          appState.likeTime = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond - 3600000);
        }
        if(userDetailsModel.meta.superLikeTime!=""){
          appState.superLikeTime = DateTime.parse(userDetailsModel.meta.superLikeTime);
        }else{
          appState.superLikeTime = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond - 3600000);
        }

        print("Superlike Count -> ${appState.superLikeCount} Superlike time -> ${appState.superLikeTime}");
        print("Like Count -> ${appState.likeCount} Like time -> ${appState.likeTime}");

        await sharedPreferences.setString(Preferences.superLikeTime, appState.superLikeTime.toString());
        await sharedPreferences.setInt(Preferences.superLikeCount, appState.superLikeCount);
        await sharedPreferences.setString(Preferences.likeTime, appState.likeTime.toString());
        await sharedPreferences.setInt(Preferences.likeCount, appState.likeCount);

        appState.subscriptionName = userDetailsModel.meta.subscriptionName;
        appState.subscriptionDate = userDetailsModel.meta.subscriptionDate;

        print(userDetailsModel.meta.toFirstJson());
        print(sharedPreferences.getString("token"));

        // await RestApi.updateUserDetails(appState.userDetailsModel.meta.toFirstJson());
        await sharedPreferences.setString(Preferences.metaData, jsonEncode(userDetailsModel.toJson()));
        final medialList = await RestApi.getSingleUserMedia();
        if(medialList!=null) {
          appState.medialList = medialList;
          await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
          Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
        }
      }
      else{
        Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => Welcome()),(Route<dynamic> route) => false);
      }
    } else {
      state.showSnackBar(confirm);
      state.setState(() {
        state.isLoading = false;
      });
    }
  }

  bool validate() {
    if (state.usernameCont.text == '') {
      state.showSnackBar('Enter username',isError: true);
      return false;
    }else if (state.passwordCont.text == '') {
      state.showSnackBar('Enter password',isError: true);
      return false;
    }
    return true;
  }
}