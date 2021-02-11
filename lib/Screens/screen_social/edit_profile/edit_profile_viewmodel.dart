import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_details_new_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:hookup4u/restapi/restapi.dart';

import 'edit_profile_screen.dart';

class EditProfileViewModel {

  EditProfilePageState state;
  EditProfileViewModel(EditProfilePageState state) {
    this.state = state;
  }

  editProfileUser() async {

      EasyLoading.show();
      Map<String, dynamic> userMapData = {
        "id" : appState.currentUserData.data.id.toString(),
        "name": state.nameTxt.text,
        // "email":"",
        "phone": state.phoneTxt.text,
        "gender": state.selectGender,
        // "date_of_birth" : state.dateOfBirth,
      };

      Map<String, dynamic> mapUserData = {
        "name": state.nameTxt.text,
      };

      final check = await RestApi.updateUserDetailsSocial(userMapData);
      if(check != null && check.statusCode == 200 && check.statusCode == 201) {
          UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(json.decode(check.body));
          Navigator.pop(state.context, mapUserData);
          print(appState.userDetailsModel.meta.toJson());
          await sharedPreferences.setString(Preferences.metaData, check.body);
          appState.currentUserData = profileDetailFromJson(sharedPreferences.getString(Preferences.profile));
          print(appState.currentUserData);
          // await sharedPreferences.setString(Preferences.metaData, jsonEncode(userDetailsModel.toJson()));
          EasyLoading.dismiss();
      } else {
        print("some thing wrong");
      }


  }


}