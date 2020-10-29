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
    if (state.usernameCont.text == '') {
      state.showSnackBar('Enter username',isError: true);
      return false;
    }else if (state.passwordCont.text == '') {
      state.showSnackBar('Enter password',isError: true);
      return false;
    }
    return true;
  }

  successfullySignUp() {
    showDialog(
        barrierDismissible: false,
        context: state.context,
        builder: (_) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(state.context,
                MaterialPageRoute(builder: (context) => ListHolderPage()),(Route<dynamic> route) => false);
          });
          return Center(
            child: Container(
              width: MediaQuery.of(state.context).size.width/2,
                height: 100,
                decoration: BoxDecoration(
                    color: ColorRes.primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login\n Successfully!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 14),
                    )
                  ],
                )),
          );
        });
  }
}