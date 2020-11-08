import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/forgot_password.dart';
import 'package:hookup4u/Screens/auth/login_viewmodel.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/util/color.dart';

class LoginPage extends StatefulWidget {
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
        if(!isLoading){
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        key: _scaffoldKey,
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
                              "USERNAME",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[200]),
                            ),
                            TextFormField(
                              style: TextStyle(
                                  fontSize: 16, color: ColorRes.textColor),
                              cursorColor: ColorRes.textColor,
                              controller: usernameCont,
                              decoration: InputDecoration(
                                hintText: "iLoveDate",
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
                               if(!isLoading){
                                 if(model.validate()){
                                   setState(() {
                                     isLoading = true;
                                   });
                                   model.login();
                                 }
                               }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * .075,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorRes.redButton,
                                ),
                                child: Center(
                                    child: isLoading ? Padding(child: CircularProgressIndicator(backgroundColor: ColorRes.primaryColor,),padding: EdgeInsets.all(5),):Text("LOGIN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(!isLoading){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                }
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
                      if(!isLoading){
                        Navigator.pop(context);
                      }
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
                    if(!isLoading){
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
                    }
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
      ),
    );
  }

  showSnackBar(String message,{bool isError = false}){
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: isError ? ColorRes.redButton: ColorRes.darkButton,
      duration: Duration(seconds: 3),
    ));
  }
}
