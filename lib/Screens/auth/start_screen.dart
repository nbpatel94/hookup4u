import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/auth/login_page.dart';
import 'package:hookup4u/Screens/auth/singup_page.dart';
import 'package:hookup4u/util/color.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                      width: MediaQuery.of(context).size.width - 150,
                      height: MediaQuery.of(context).size.height / 2.5,
                      image: AssetImage("asset/Icon/logo_white.png")),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(" Social Network \n and Matchmaking", style: TextStyle(fontSize: 40, color: ColorRes.white)),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15, bottom: 40),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Meet and connect with Muslims in a  private, secure network, and the largest community for finding relationships.",
                      style: TextStyle(fontSize: 20, color: ColorRes.white)),
                ),


                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(isShowBackArrow: true)));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .075,
                    // width: MediaQuery.of(context).size.height * .300,
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorRes.white,
                    ),
                    child: Center(
                        child: Text("LOGIN",
                            style: TextStyle(
                                color: ColorRes.primaryRed,
                                fontSize: 16,
                                fontFamily: 'NeueFrutigerWorld',
                                fontWeight: FontWeight.w700))),
                  ),
                ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .075,
                        // width: MediaQuery.of(context).size.height * .300,
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorRes.primaryRed,
                        ),
                        child: Center(
                            child: Text("SIGN UP",
                                style: TextStyle(
                                    color: ColorRes.white,
                                    fontSize: 16,
                                    fontFamily: 'NeueFrutigerWorld',
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),

                SizedBox(
                      height: 30,
                )
              ]),
            ),
          ),
        ),
      ),
      onWillPop: () async{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
