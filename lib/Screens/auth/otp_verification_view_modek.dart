import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/otp_verification.dart';
import 'package:hookup4u/restapi/restapi.dart';

class OtpVerificationViewModel {
  VerificationState state;

  OtpVerificationViewModel(this.state);

  signUp() async {
    bool confirm = await RestApi.signUpApi('devid', 'Developer', 'dev@user.com', 'dev@123');
    state.setState(() {
      state.isLoading = false;
    });
    if(confirm) {
      successfullySignUp();
    }
  }

  successfullySignUp() {
    showDialog(
        barrierDismissible: false,
        context: state.context,
        builder: (_) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(state.context,
                MaterialPageRoute(builder: (context) => Welcome()),
              ModalRoute.withName('/'));
          });
          return Center(
              // Aligns the container to center
              child: Container(
                  // A simplified version of dialog.
                  width: 180.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "asset/auth/verified.jpg",
                        height: 100,
                      ),
                      Text(
                        "Verified\n Successfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20),
                      )
                    ],
                  )));
        });
  }
}
