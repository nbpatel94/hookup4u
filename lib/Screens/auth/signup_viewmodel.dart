import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';

class SignUpViewModel {
  SignUpPageState state;

  SignUpViewModel(this.state);

  signUp() async {
    String confirm = await RestApi.signUpApi(
        state.userIdCont.text.trim(),
        state.userNameCont.text.trim(),
        state.emailCont.text.trim(),
        state.passwordCont.text.trim());
    state.setState(() {
      state.isLoading = false;
    });
    if (confirm == 'success') {
      successfullySignUp();
    }else{
      state.showSnackBar(confirm);
    }

    // successfullySignUp();
  }

  bool validate() {
    if (state.userIdCont.text == '') {
      state.showSnackBar('Enter username',isError: true);
      return false;
    }else if (state.userNameCont.text == '') {
      state.showSnackBar('Enter name',isError: true);
      return false;
    } else if (state.emailCont.text == '') {
      state.showSnackBar('Enter email',isError: true);
      return false;
    } else if (!isEmail(state.emailCont.text.trim())) {
      state.showSnackBar('Enter valid email',isError: true);
      return false;
    } else if (state.passwordCont.text == '') {
      state.showSnackBar('Enter password',isError: true);
      return false;
    }
    return true;
  }

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  successfullySignUp() {
    showDialog(
        barrierDismissible: false,
        context: state.context,
        builder: (_) {
          Future.delayed(Duration(seconds: 7), () {
            Navigator.pushReplacement(
                state.context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          });
          return Center(
              child: Container(
                  width: MediaQuery.of(state.context).size.width/1.3,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorRes.primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      """Sign Up Successfully\n\nActivation link sent to "${state.emailCont.text.trim()}"\n\nFirst verify your account.""",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  )));
        });
  }
}
