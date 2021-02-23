import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/auth/signup_viewmodel.dart';
import 'package:hookup4u/Screens/auth/verify_otp_screen.dart';
import 'package:hookup4u/util/color.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  SignUpViewModel model;

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController userIdCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = SignUpViewModel(this));

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
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 25, top: 50),
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w400),
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
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16, color: ColorRes.white),
                          cursorColor: ColorRes.textColor,
                          controller: userIdCont,
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: ColorRes.textColor, fontSize: 16),
                            focusColor: ColorRes.textColor,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                            // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)
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
                          controller: userNameCont,
                          decoration: InputDecoration(
                            hintText: "Name",
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
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.greyBg,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 16, color: ColorRes.white),
                          cursorColor: ColorRes.textColor,
                          controller: emailCont,
                          decoration: InputDecoration(
                            hintText: "Email address",
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
                          controller: passwordCont,
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
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isLoading) {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                            if (model.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              model.signUp();
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .075,
                          // width: MediaQuery.of(context).size.width / 3.5,
                          margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
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
                                  : Text("SIGNUP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'NeueFrutigerWorld',
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            if (!isLoading) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(isShowBackArrow: true)));
                            }
                          },
                          child: Text(
                            "Already a member? Login",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'NeueFrutigerWorld',
                                color: ColorRes.textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
      duration: Duration(seconds: 3),
    ));
  }
}
