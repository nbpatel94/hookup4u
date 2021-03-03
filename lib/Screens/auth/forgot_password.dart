import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/forgot_viewmodel.dart';
import 'package:hookup4u/util/color.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {

  ForgotViewModel model;

  TextEditingController emailCont = TextEditingController();
  TextEditingController codeCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmCont = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isVerified = false;
  bool isCodeSend = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    model ?? (model = ForgotViewModel(this));

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: isVerified ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 15, left: 15),
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 36,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w100, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30,left: 40,right: 40),
                      child: Text (
                        "Enter your new password and do not share this password with anyone",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14, fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor),
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
                                fontSize: 16,fontFamily: 'NeueFrutigerWorld', color: Colors.grey[200]),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CONFIRM PASSWORD",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16,fontFamily: 'NeueFrutigerWorld', color: Colors.grey[200]),
                          ),
                          TextFormField(
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: confirmCont,
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
                      child: GestureDetector(
                        onTap: () {
                          if(!isLoading) {
                            if (model.validate()) {
                              model.resetPassword();
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .075,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorRes.redButton,
                          ),
                          child: Center(
                              child: isLoading ? Padding(child: CircularProgressIndicator(backgroundColor: ColorRes.primaryColor,),padding: EdgeInsets.all(5),):Text("RESET",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'NeueFrutigerWorld',
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ],
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container (
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 15, left: 25),
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 36, fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w300,color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30,left: 25,right: 40),
                      child: Text(
                        "Please enter your email address. You will receive a link to create a new password via email.",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, fontFamily: 'NeueFrutigerWorld',color: ColorRes.white),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: ColorRes.greyBg,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField (
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 16, color: ColorRes.white),
                        cursorColor: ColorRes.textColor,
                        controller: emailCont,
                        decoration: InputDecoration(
                          hintText: "example@example.com",
                          hintStyle: TextStyle(color: ColorRes.white, fontSize: 16),
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

                    !isCodeSend ? Container(): Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "VERIFICATION CODE",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'NeueFrutigerWorld',color: Colors.grey[200]),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: codeCont,
                            decoration: InputDecoration(
                              hintText: "1234",
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
                    Row(
                      mainAxisAlignment: !isCodeSend ? MainAxisAlignment.start: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector (
                          onTap: () {
                            if(!isLoading) {
                              if (isCodeSend) {
                                if (model.validate()) {
                                  model.verifyVerificationCode();
                                }
                              } else {
                                if (model.validate()) {
                                  model.sendVerificationCode();
                                }
                              }
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .075,
                            width: MediaQuery.of(context).size.width / 2.5,
                            margin: EdgeInsets.only(left: 25, right: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorRes.redButton,
                            ),
                            child: Center(
                                child: isLoading ? Padding(child: CircularProgressIndicator(backgroundColor: ColorRes.primaryColor,),padding: EdgeInsets.all(5),): Text(isCodeSend ? "VERIFY" :"SEND",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'NeueFrutigerWorld',
                                        fontWeight: FontWeight.w700))),
                          ),
                        ),
                        !isCodeSend ? Container(): Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              if(!isLoading) {
                                if (model.validate(bool: false)) {
                                  setState(() {
                                    isCodeSend = false;
                                  });
                                  model.sendVerificationCode();
                                }
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .075,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorRes.darkButton,
                              ),
                              child: Center(
                                  child: Text("RESEND",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'NeueFrutigerWorld',
                                          fontWeight: FontWeight.w700))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  iconSize: 30),
            )
          ],
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
