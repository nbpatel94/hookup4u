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

class LoginViewModel{
  LoginPageState state;

  LoginViewModel(this.state);

  login() async {
    String confirm = await RestApi.logInApi(state.usernameCont.text.trim(), state.passwordCont.text.trim());
    if (confirm == 'success') {
      if(sharedPreferences.containsKey(Preferences.metaData)){
        print("meta contain");
        UserDetailsModel userDetailsModel = userDetailsModelFromJson(sharedPreferences.getString(Preferences.metaData));
        appState.userDetailsModel = userDetailsModel;
        appState.children = userDetailsModel.meta.children;
        appState.relation = userDetailsModel.meta.relation;
        appState.livingIn = userDetailsModel.meta.livingIn;
        appState.jobTitle = userDetailsModel.meta.jobTitle;
        appState.about = userDetailsModel.meta.about;
        print(userDetailsModel.meta.toJson());
        if(sharedPreferences.containsKey(Preferences.mediaData)){
          print("media contain");
          List<MediaModel> mediaList = mediaListFromJson(sharedPreferences.getString(Preferences.mediaData));
          appState.medialList = mediaList;
          Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
        }
        else{
          print("media !contain");
          final medialList = await RestApi.getSingleUserMedia();
          if(medialList!=null){
            appState.medialList = medialList;
            await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
            Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
          }
        }
      }else{
        print("meta !contain");
        UserDetailsModel userDetailsModel = await RestApi.getSingleUserDetails(appState.id);
        if(userDetailsModel!=null && userDetailsModel.meta.about!=""){
          appState.userDetailsModel = userDetailsModel;
          appState.children = userDetailsModel.meta.children;
          appState.relation = userDetailsModel.meta.relation;
          appState.livingIn = userDetailsModel.meta.livingIn;
          appState.jobTitle = userDetailsModel.meta.jobTitle;
          appState.about = userDetailsModel.meta.about;
          print(userDetailsModel.meta.toJson());
          await sharedPreferences.setString(Preferences.metaData, jsonEncode(userDetailsModel.toJson()));
          final medialList = await RestApi.getSingleUserMedia();
          if(medialList!=null){
            appState.medialList = medialList;
            await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
            Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
          }
        }else{
          Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => Welcome()),(Route<dynamic> route) => false);
        }
      }

    }else{
      state.showSnackBar(confirm);
      state.setState(() {
        state.isLoading = false;
      });
    }

    // String confirm = await RestApi.logInApi(state.usernameCont.text.trim(), state.passwordCont.text.trim());
    // if (confirm == 'success') {
    //     Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
    // }else{
    //   state.showSnackBar(confirm);
    // }

    // successfullySignUp();
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