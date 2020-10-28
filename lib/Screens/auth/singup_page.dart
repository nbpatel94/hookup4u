import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/util/color.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
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
                      margin: EdgeInsets.only(bottom: 20, left: 50),
                      child: Text(
                        "Signup",
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
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: userNameCont,
                            decoration: InputDecoration(
                              hintText: "iLoveDate1",
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
                          vertical: 10, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "YOUR AGE",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[200]),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: emailCont,
                            decoration: InputDecoration(
                              hintText: "21",
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
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorRes.lightButton,
                              ),
                              child: Center(
                                  child: Text("SIGNUP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage()));
                            },
                            child: Text(
                              "Already a member? Login",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12, color: ColorRes.textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
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
    );
  }
}
