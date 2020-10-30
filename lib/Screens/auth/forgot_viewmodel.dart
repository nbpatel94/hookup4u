import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/forgot_password.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';

class ForgotViewModel {
  ForgotPasswordState state;

  ForgotViewModel(this.state);

  sendVerificationCode() async {
    state.setState(() {
      state.isLoading = true;
    });
    String confirm = await RestApi.requestVerificationCodeApi(state.emailCont.text.trim());
    if(confirm=='success'){
      state.setState(() {
        state.isCodeSend = true;
        state.isLoading = false;
      });
    }else{
      state.setState(() {
        state.isLoading = false;
      });
      state.showSnackBar(confirm);
    }
  }

  verifyVerificationCode() async {
    state.setState(() {
      state.isLoading = true;
    });
    String confirm = await RestApi.verifyVerificationCodeApi(state.emailCont.text.trim(),state.codeCont.text.trim());
    if(confirm=='success'){
      state.setState(() {
        state.isVerified = true;
        state.isLoading = false;
      });
    }else{
      state.setState(() {
        state.isLoading = false;
      });
      state.showSnackBar(confirm);
    }
  }

  resetPassword() async {
    state.setState(() {
      state.isLoading = true;
    });
    String confirm = await RestApi.resetPasswordApi(state.emailCont.text.trim(),state.passwordCont.text.trim(),state.codeCont.text.trim());
    if(confirm=='success'){
      state.setState(() {
        state.isLoading = false;
      });
      successfullySignUp();
    }else{
      state.setState(() {
        state.isLoading = false;
      });
      state.showSnackBar(confirm);
    }
  }

  bool validate({bool bool=true}) {
    if(state.isCodeSend){
      if(state.isVerified) {
        if (state.passwordCont.text == '') {
          state.showSnackBar('Enter password', isError: true);
          return false;
        } else if (state.confirmCont.text == '') {
          state.showSnackBar('Enter confirm password', isError: true);
          return false;
        } else if (state.passwordCont.text != state.confirmCont.text) {
          state.showSnackBar('Password does not match', isError: true);
          return false;
        }
      }else{
        if(bool) {
          if (state.codeCont.text == '') {
            state.showSnackBar('Enter code', isError: true);
            return false;
          } else if (state.codeCont.text.length != 4) {
            state.showSnackBar('Enter 4 digit', isError: true);
            return false;
          }
        }
      }
    }else{
      if (state.emailCont.text == '') {
        state.showSnackBar('Enter email',isError: true);
        return false;
      } else if (!isEmail(state.emailCont.text.trim())) {
        state.showSnackBar('Enter valid email',isError: true);
        return false;
      }
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
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
                state.context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          });
          return Center(
              child: Container(
                  width: MediaQuery.of(state.context).size.width/1.3,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorRes.primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      """Password reset Successfully""",
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