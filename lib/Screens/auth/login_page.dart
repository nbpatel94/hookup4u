import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/forgot_password.dart';
import 'package:hookup4u/Screens/auth/login_viewmodel.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/Screens/screen_social/invite_friends/invite_friends_screen.dart';
import 'package:hookup4u/Screens/screen_social/main_screen.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  final bool isShowBackArrow;
  const LoginPage({Key key, this.isShowBackArrow = false}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();

}

class LoginPageState extends State<LoginPage> {

  LoginViewModel model;

  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = LoginViewModel(this));

    return WillPopScope(
      onWillPop: () async {
        if (!isLoading) {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        key: _scaffoldKey,

        body: SafeArea(
          child: SingleChildScrollView (
            child: Column(
              // alignment: Alignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                widget.isShowBackArrow ? Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: IconButton(
                        onPressed: () {
                          if (!isLoading) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        iconSize: 30),
                  ),
                ) : Container(),

                Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 30),
                        child: Text(
                          "Welcome back",
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 30),
                          child: Text("Login to your account", style: TextStyle(fontSize: 16, color: Colors.white))
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: ColorRes.greyBg,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 16, color: ColorRes.white),
                          cursorColor: ColorRes.textColor,
                          controller: usernameCont,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: ColorRes.textColor, fontSize: 16),
                            focusColor: ColorRes.textColor,

                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                            // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.greyBg,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 16, color: ColorRes.white),
                          cursorColor: ColorRes.textColor,
                          controller: passwordCont,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "password",
                            hintStyle: TextStyle(
                                color: ColorRes.textColor, fontSize: 16),
                            focusColor: ColorRes.textColor,

                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                            // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      GestureDetector (
                        onTap: () {
                          if (!isLoading) {
                            if (model.validate()) {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SocialMainPage()));
                              setState(() {
                                isLoading = true;
                              });
                              model.login();
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .075,
                          // width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ColorRes.redButton,
                          ),
                          child: Center(
                              child: isLoading
                                  ? Padding(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            ColorRes.primaryColor,
                                      ),
                                      padding: EdgeInsets.all(5),
                                    )
                                  : Text("LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'NeueFrutigerWorld',
                                          fontWeight: FontWeight.w700))),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (!isLoading) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPassword()));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 40),
                          child: Text(
                            "Forgot password?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'NeueFrutigerWorld',
                                color: ColorRes.textColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Container(
                      color: Color(0xff192E3F),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          if (!isLoading) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
                          }
                        },
                        child: Text(
                          "Don't have account? Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorRes.textColor,
                              fontFamily: 'NeueFrutigerWorld',
                              fontSize: 15),
                        ),
                      )),
                )

              ],
            ),
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
      duration: Duration(seconds: 3),
    ));
  }
}
