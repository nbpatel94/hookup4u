import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/start_screen.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {



  getSharedDetails() async {
    if(sharedPreferences.containsKey(Preferences.accessToken)){
      appState.accessToken = sharedPreferences.getString(Preferences.accessToken);
      appState.currentUserData = profileDetailFromJson(sharedPreferences.getString(Preferences.profile));
      if(sharedPreferences.containsKey(Preferences.metaData)){
        print("meta contain");
        UserDetailsModel userDetailsModel = userDetailsModelFromJson(sharedPreferences.getString(Preferences.metaData));
        appState.userDetailsModel = userDetailsModel;
        appState.children = userDetailsModel.meta.children;
        appState.gender = userDetailsModel.meta.gender;
        appState.relation = userDetailsModel.meta.relation;
        appState.livingIn = userDetailsModel.meta.livingIn;
        appState.jobTitle = userDetailsModel.meta.jobTitle;
        appState.about = userDetailsModel.meta.about;
        appState.id = userDetailsModel.id;
        // print(userDetailsModel.meta.toJson());
        if(sharedPreferences.containsKey(Preferences.mediaData)){
          print("media contain");
          List<MediaModel> mediaList = mediaListFromJson(sharedPreferences.getString(Preferences.mediaData));
          appState.medialList = mediaList;
          print('Current User : ${appState.id}');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          });
        }
        else{
          print("media !contain");
          final medialList = await RestApi.getSingleUserMedia();
          if(medialList!=null){
            appState.medialList = medialList;
            await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          }
        }
      }
      else{
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          }
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
        }
      }
    }else{
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.primaryColor,
        body: Center(
          child: Container(
              height: 120,
              width: 200,
              child: SvgPicture.asset(
                "asset/hookup4u-Logo-BP.svg",
                fit: BoxFit.contain,
              )),
        ));
  }

  @override
  void initState() {
    super.initState();
    getSharedDetails();
  }
}
