import 'dart:convert';

import 'package:hookup4u/models/change_password_model.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/utils.dart';

import '../../../app.dart';
import 'change_password_screen.dart';

class ChangePasswordViewModel {

  ChangePasswordPageState state;

  ChangePasswordViewModel(ChangePasswordPageState state) {
    this.state = state;
  }


  bool passwordMatch() {
    if (state.currentPassword.text == '') {
      // state.showSnackBar('Current Password is empty',isError: true);
      Utils().showToast("Current Password is empty");
      return false;
    } else if (state.password.text == '') {
      // state.showSnackBar('Password is empty',isError: true);
      Utils().showToast("Password is empty");
      return false;
    } else if (state.conformPassword.text == '') {
      // state.showSnackBar('Conform password is empty',isError: true);
      Utils().showToast("Conform password is empty");
      return false;
    } else if (state.password.text != state.conformPassword.text) {
      // state.showSnackBar('Password does not match',isError: true);
      Utils().showToast("Password does not match");
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

  changePassword() {

    Map userPasswordMap = {
      "user_id": appState.id.toString(),
      "password": state.currentPassword.text,
      "new_password":state.password.text,
    };

    RestApi.postChangePasswordApi(userPasswordMap).then((value) {
      state.isLoadingPassword = false;
      state.setState(() { });
      if(value != null && value.statusCode == 200 || value.statusCode == 201) {
        PasswordChangeModel passwordChangeModel = PasswordChangeModel.fromJson(json.decode(value.body));
        // appState.currentUserData.data.displayName = state.nameTxt.text;
        if(passwordChangeModel.code == 200) {

          state.currentPassword.clear();
          state.password.clear();
          state.conformPassword.clear();

          Utils().showToast(passwordChangeModel.message);
        } else if(passwordChangeModel.code == 500) {
          Utils().showToast(passwordChangeModel.message);
        } else {
          Utils().showToast("Some thing wrong");
        }
      } else {
        Utils().showToast("Some thing wrong");
      }
    });
  }



}