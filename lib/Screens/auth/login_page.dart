import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/forgot_password.dart';
import 'package:hookup4u/Screens/auth/otp_verification.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/util/color.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30, left: 50),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 34, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EMAIL ADDRESS",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[200]),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: emailCont,
                            decoration: InputDecoration(
                              hintText: "example@example.com",
                              hintStyle: TextStyle(
                                  color: ColorRes.textColor, fontSize: 16),
                              focusColor: ColorRes.textColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorRes.textColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorRes.textColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PASSWORD",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[200]),
                          ),
                          TextFormField(
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: passwordCont,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "••••••",
                              hintStyle: TextStyle(
                                  color: ColorRes.textColor, fontSize: 16),
                              focusColor: ColorRes.textColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorRes.textColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorRes.textColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .075,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorRes.lightButton,
                              ),
                              child: Center(
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPassword()));
                            },
                            child: Text(
                              "Forgot password?",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15, color: ColorRes.textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    iconSize: 30),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Container(
                    color: Color(0xff192E3F),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Text("Don't have account? Sign up",textAlign: TextAlign.center,style: TextStyle(color: ColorRes.textColor,fontSize: 15),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
