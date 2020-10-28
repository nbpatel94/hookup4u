import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailCont = TextEditingController();

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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30,left: 40,right: 40),
                      child: Text(
                        "Enter your email address, we'll send you the instruction on how to change your password",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14, color: ColorRes.textColor),
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
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .075,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorRes.lightButton,
                          ),
                          child: Center(
                              child: Text("SEND",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
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
