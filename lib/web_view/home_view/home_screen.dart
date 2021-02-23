import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Container(
        width: Utils().getDeviceWidth(context),
        // height: Utils().getDeviceHeight(context),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [

              Container(
                // margin: EdgeInsets.only(left: 20, right: 20),
                width: Utils().getDeviceWidth(context),
                height: Utils().getDeviceHeight(context),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("asset/Icon/web_bg.jpg"), fit: BoxFit.fill)
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150),
                    titleText(),
                    SizedBox(height: 30),
                    subTitle(),
                    SizedBox(height: 50),
                    signUpLoginButton(),
                    SizedBox(height: 80),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(height: 2, color: ColorRes.white)),

                    appStorePlayStoreView(),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(height: 2, color: ColorRes.white)
                    ),
                    SizedBox(height: 100)
                  ],
                ),

              ),

              Container(
                height: 250,
                width: Utils().getDeviceWidth(context),
                child: Column(
                  children: [

                    SizedBox(height: 10),
                    Image(
                        height: 150,
                        width: 150,
                        image: AssetImage('asset/Icon/icon_dark.png')
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bottomText("About"),
                        bottomText("Privacy"),
                        bottomText("Community"),
                        bottomText("Mission"),
                        bottomText("SignUp"),
                        bottomText("Login"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("Copyright 2021 iheartmuslim.com", style: TextStyle(color: ColorRes.black, fontSize: 15))

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  titleText() {
    return Text("Matchmaking for the Muslim Community", style: TextStyle(fontSize: 50, color: ColorRes.white, letterSpacing: 2), textAlign: TextAlign.center);

  }

  subTitle() {
    return Text("Private social network to help you find the love life with security, privacy and discretion.", style: TextStyle(fontSize: 18, color: ColorRes.white), textAlign: TextAlign.center);
  }

  signUpLoginButton() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkResponse(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Container(
            width: 200,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorRes.bgButton,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Text("SIGN UP", style: TextStyle(color: ColorRes.white, fontSize: 22)),
          ),
        ),
        SizedBox(width: 10),
        InkResponse(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(isShowBackArrow: true)));
          },
          child: Container(
            width: 200,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorRes.bgButton1,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Text("LOGIN", style: TextStyle(color: ColorRes.black, fontSize: 22)),
          ),
        )
      ],
    );
  }

  appStorePlayStoreView() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          margin: EdgeInsets.only(top: 30, bottom: 30),
          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: ColorRes.black, spreadRadius: 1)]
          ),
          child: Row(
            children: [

              Image(
                  height: 28,
                  width: 28,
                  color: ColorRes.black,
                  image: AssetImage("asset/Icon/apple.png")),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Download on the", style: TextStyle(color: ColorRes.black, fontSize: 10)),
                  SizedBox(width: 5),
                  Text("App Store", style: TextStyle(color: ColorRes.black, fontSize: 16)),
                ],
              )
            ],
          ),
        ),

        SizedBox(width: 10),

        Container(
          height: 45,
          margin: EdgeInsets.only(top: 30, bottom: 30),
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: ColorRes.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorRes.white, width: 1)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                  height: 28,
                  width: 28,
                  image: AssetImage("asset/Icon/play_store.png")),
              SizedBox(width: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get it on", style: TextStyle(color: ColorRes.white, fontSize: 10)),
                  SizedBox(width: 5),
                  Text("Google Play", style: TextStyle(color: ColorRes.white, fontSize: 16)),
                ],
              )
            ],
          ),
        ),

      ],
    );
  }

  bottomText(String title) {
    return Text("$title | ", style: TextStyle(color: ColorRes.black, fontSize: 20));
  }

}
