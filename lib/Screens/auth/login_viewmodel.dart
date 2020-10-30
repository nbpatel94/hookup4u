import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';

class LoginViewModel{
  LoginPageState state;

  LoginViewModel(this.state);

  login() async {
    String confirm = await RestApi.logInApi(state.usernameCont.text.trim(), state.passwordCont.text.trim());
    if (confirm == 'success') {
      Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
    }else{
      state.showSnackBar(confirm);
    }

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