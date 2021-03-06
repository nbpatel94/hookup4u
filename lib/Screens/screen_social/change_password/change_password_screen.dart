import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';

import 'change_password_viewmodel.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {


  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoadingPassword = false;
  
  ChangePasswordViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = ChangePasswordViewModel(this));

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar (
        elevation: 0.0
      ),
      body: SingleChildScrollView (
        child: Container (
          margin: EdgeInsets.only(left:  10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container (
                height: 50,
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Change Password", style: TextStyle(color: ColorRes.white, fontSize: 25)),
                    // Text("edit",  style: TextStyle(color: ColorRes.white, fontSize: 14)),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.0,
                color: ColorRes.greyBg.withOpacity(0.5),
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: ColorRes.greyBg,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 16, color: ColorRes.white),
                        cursorColor: ColorRes.textColor,
                        controller: currentPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Current Password",
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 16),
                          focusColor: ColorRes.textColor,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: ColorRes.greyBg,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 16, color: ColorRes.white),
                        cursorColor: ColorRes.textColor,
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 16),
                          focusColor: ColorRes.textColor,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: ColorRes.greyBg,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField (
                        style: TextStyle (
                            fontSize: 16, color: ColorRes.white
                        ),
                        cursorColor: ColorRes.textColor,
                        controller: conformPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Conform Password",
                          hintStyle: TextStyle (
                              color: ColorRes.textColor, fontSize: 16),
                          focusColor: ColorRes.textColor,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {

                        if (!isLoadingPassword) {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                          if (model.passwordMatch()) {
                            setState(() {
                              isLoadingPassword = true;
                            });
                            model.changePassword();
                          }
                        }

                      },
                      child: Container(
                        height: 50,
                        // height: MediaQuery.of(context).size.height * .075,
                        // width: MediaQuery.of(context).size.width / 3.5,
                        margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorRes.redButton,
                        ),
                        child: Center(
                            child: isLoadingPassword
                                ? Padding(
                              child: CircularProgressIndicator (
                                backgroundColor: ColorRes.primaryColor,
                              ),
                              padding: EdgeInsets.all(5),
                            )
                                : Text("Update password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(String message, {bool isError = false}) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: isError ? ColorRes.redButton : ColorRes.darkButton,
      duration: Duration(seconds: 10),
    ));
  }

}
