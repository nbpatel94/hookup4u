import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/auth/verify_otp_screen.dart';
import 'package:hookup4u/restapi/restapi.dart';

class VerifyOtpViewModel{

  VerifyOtpScreenState state;

  VerifyOtpViewModel(VerifyOtpScreenState state) {
    this.state = state;
  }


  otpVerifyApi() async {

    state.setState(() {
      state.isLoading = true;
    });
    Map<String, dynamic> otpMapData = {
      "username": state.widget.emailStr,
      "otp": state.orpController.text,
    };
    RestApi.postOtpVerifyOtp(otpMapData).then((response) {
      state.setState(() {
        state.isLoading = false;
      });
      print(response);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if(jsonData['code'] == 200 && jsonData['status'] == "success") {
        Navigator.pushAndRemoveUntil(state.context, MaterialPageRoute(builder: (context) => LoginPage(isShowBackArrow: false)),(Route<dynamic> route) => false);
      } else if(jsonData['status'] == "error") {
        print(jsonData['message']);
        state.showSnackBar(jsonData['message']);
      } else {
        print("Some thing wrong");
        state.showSnackBar("Some thing wrong");
      }
    });
  }

  reSendOtp() {

    Map<String, dynamic> reSendOtp = {
      "username": state.widget.emailStr,
    };

    RestApi.reSendOtp(reSendOtp).then((response) {
      print(response);
      Map<String, dynamic> jsonData = {};
      if(jsonData['code'] == 200 && jsonData['status'] == "success") {
      }
    });

  }


}