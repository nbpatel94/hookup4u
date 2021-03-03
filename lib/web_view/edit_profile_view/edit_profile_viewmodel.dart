import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:hookup4u/restapi/restapi.dart';

import 'edit_profile_screen.dart';

class EditProfileViewModel {

  EditWebProfilePageState state;

  EditProfileViewModel(EditWebProfilePageState state) {
    this.state = state;
  }


  bool validate() {
    if (state.nameTxt.text == '') {
      state.showSnackBar('Enter Name',isError: true);
      return false;
    } else if (state.selectGender == '') {
      state.showSnackBar('Select Gender',isError: true);
      return false;
    } else if (state.dateOfBirth == '' || state.dateOfBirth == 'Date of birth') {
      state.showSnackBar('Select Date Of Birth',isError: true);
      return false;
    } /* else if (!isEmail(state.emailCont.text.trim())) {
      state.showSnackBar('Enter valid email',isError: true);
      return false;
    } else if (state.passwordCont.text == '') {
      state.showSnackBar('Enter password',isError: true);
      return false;
    }*/
    return true;
  }

  editProfileUser() async {

    // EasyLoading.show();

    Map<String, dynamic> userMapData = {
      "id" : appState.currentUserData.data.id.toString(),
      // "name": state.nameTxt.text,
      // "email":"",
      // "phone": state.phoneTxt.text,
      "gender": state.selectGender,
      "date_of_birth" : state.dateOfBirth,
    };

    Map<String, dynamic> mapUserData = {
      "name": state.nameTxt.text
    };

    RestApi.updateUserName(mapUserData).then((value) {
      appState.currentUserData.data.displayName = state.nameTxt.text;
    });

    final check = await RestApi.updateUserDetailsSocial(userMapData);
    // EasyLoading.dismiss();
    if(check != null && check.statusCode == 200 || check.statusCode == 201) {
      UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(json.decode(check.body));
      Navigator.pop(state.context, mapUserData);
      print(appState.userDetailsModel.meta.toJson());

      appState.currentUserData.data.displayName = state.nameTxt.text;
      appState.userDetailsModel.meta.name = state.nameTxt.text;
      appState.userDetailsModel.meta.gender = state.selectGender;
      appState.userDetailsModel.meta.dateOfBirth = state.dateOfBirth;

      await sharedPreferences.setString(Preferences.metaData, check.body);
      appState.currentUserData = profileDetailFromJson(sharedPreferences.getString(Preferences.profile));
      print(appState.currentUserData);
      // await sharedPreferences.setString(Preferences.metaData, jsonEncode(userDetailsModel.toJson()));
    } else {
      print("some thing wrong");
    }
  }




}