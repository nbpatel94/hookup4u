import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/verify_otp_viewmodel.dart';
import 'package:hookup4u/util/color.dart';

class VerifyOtpScreen extends StatefulWidget {

  final String emailStr;
  const VerifyOtpScreen({Key key, this.emailStr}) : super(key: key);

  @override
  VerifyOtpScreenState createState() => VerifyOtpScreenState();
}

class VerifyOtpScreenState extends State<VerifyOtpScreen> with TickerProviderStateMixin {

  TextEditingController orpController = TextEditingController();
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _controller;
  int levelClock = 120;

  bool isClockShow = false;

  VerifyOtpViewModel model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    model ?? (model = VerifyOtpViewModel(this));

    _controller = AnimationController(vsync: this, duration: Duration(seconds: levelClock)); // gameData.levelClock is a user entered number elsewhere in the applciation

    // _controller.forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    return Scaffold(
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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Verify Otp",
                        style: TextStyle(fontSize: 36,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w100, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30,left: 40,right: 40),
                      child: Text(
                        "Please type the  verification code sent to this email ${widget.emailStr}",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OTP",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16,fontFamily: 'NeueFrutigerWorld', color: Colors.grey[200]),
                          ),
                          TextFormField(
                            style: TextStyle(
                                fontSize: 16, color: ColorRes.textColor),
                            cursorColor: ColorRes.textColor,
                            controller: orpController,
                            // obscureText: true,
                            decoration: InputDecoration(
                              hintText: "OTP",
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

                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 50, left: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          isClockShow ? Countdown(
                            animation: StepTween(
                              begin: levelClock, // THIS IS A USER ENTERED NUMBER
                              end: 0,
                            ).animate(_controller),
                            end: (value) {
                              print(value);
                              if(value == 5) {
                                isClockShow = false;

                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() { });
                                });

                              }
                            },
                          ) : Container(),

                          InkWell(
                            onTap: () {
                              if(isClockShow == false) {

                                setState(() {
                                isClockShow = true;
                              });

                              _controller = AnimationController(vsync: this, duration: Duration(seconds: levelClock)); // gameData.levelClock is a user entered number elsewhere in the applciation
                              _controller.forward();

                               model.reSendOtp();
                              }
                            },
                            child: Text(
                              "Resend Otp",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14, fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor),
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      child: GestureDetector(
                        onTap: () {
                          if(!isLoading) {
                            // if (model.validate()) {
                            //   model.resetPassword();
                            // }
                            model.otpVerifyApi();
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
                              child: isLoading ? Padding(child: CircularProgressIndicator(backgroundColor: ColorRes.primaryColor,),padding: EdgeInsets.all(5)):
                              Text("Verify Otp",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'NeueFrutigerWorld',
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ],
                )
         
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


class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation, this.end}) : super(key: key, listenable: animation);
  Animation<int> animation;
  Function(int) end;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    if(clockTimer.inMinutes == 0 && clockTimer.inSeconds == 0) {
      end(5);
    }

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 25,
        color: ColorRes.white,

      ),
    );
  }
}
