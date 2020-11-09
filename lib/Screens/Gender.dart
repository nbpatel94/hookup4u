import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/SexualOrientation.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/util/color.dart';

class Gender extends StatefulWidget {
  bool generated;

  Gender({this.generated = false});

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  bool man = false;
  bool woman = false;
  bool select = false;

  bool isIm = false;
  bool isLiving = false;
  bool isJobTitle = false;

  TextEditingController livingCont = TextEditingController();
  TextEditingController jobTitleCont = TextEditingController();
  TextEditingController aboutCont = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  snackbar(String text) {
    final snackBar = SnackBar(
      content: Text('$text ',style: TextStyle(color: ColorRes.white),textAlign: TextAlign.center,),
      backgroundColor: ColorRes.redButton,
      duration: Duration(milliseconds: 1500),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return WillPopScope(
      onWillPop: ()async{
        if(isJobTitle){
          setState(() {
            isJobTitle = false;
          });
        }else if(isLiving){
          setState(() {
            isLiving = false;
          });
        }else if(isIm){
          setState(() {
            isIm = false;
          });
        }else{
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorRes.primaryColor,
        bottomNavigationBar: Container(
          child: GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                    color: ColorRes.redButton),
                height: MediaQuery.of(context).size.height * .065,
                margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
                child: Center(
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ))),
            onTap: () {
              if(widget.generated){
                if(man || woman) {
                  if(man){
                    appState.gender = 'Man';
                  }else{
                    appState.gender = 'Woman';
                  }
                  Navigator.pop(context);
                }else{
                  snackbar('Select gender');
                }
              }else{
                if(isJobTitle){
                  if(jobTitleCont.text.trim()!=''){
                    appState.jobTitle = jobTitleCont.text.trim();
                    appState.userDetailsModel.meta.jobTitle = appState.jobTitle;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SexualOrientation()));
                  }else{
                    snackbar('Write something about what do you do');
                  }
                } else if(isLiving){
                  if(livingCont.text.trim()!=''){
                    appState.livingIn = livingCont.text.trim();
                    appState.userDetailsModel.meta.livingIn = appState.livingIn;
                    setState(() {
                      isJobTitle = true;
                    });
                  }else{
                    snackbar('Write where do you live');
                  }
                } else if(isIm){
                  if(aboutCont.text.trim()!=''){
                    appState.about = aboutCont.text.trim();
                    appState.userDetailsModel.meta.about = appState.about;
                    setState(() {
                      isLiving = true;
                    });
                  }else{
                    snackbar('Write something about you');
                  }
                } else {
                  if(man || woman) {
                    if(man){
                      appState.gender = 'man';
                    }else{
                      appState.gender = 'woman';
                    }
                    appState.userDetailsModel = UserDetailsModel();
                    appState.userDetailsModel.meta = Meta();
                    appState.userDetailsModel.meta.gender = appState.gender;
                    setState(() {
                      isIm = true;
                    });
                  }else{
                    snackbar('Select gender');
                  }
                }
              }
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                isIm ?
                isLiving ?
                isJobTitle ? "Job title" : "Living in": "About me" : "I am",
                style: TextStyle(fontSize: 30,color: ColorRes.white),
              ),
              padding: EdgeInsets.only(bottom: 50),
            ),
            Center(
              child: isIm ?
              isLiving ?
              isJobTitle ?
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "JOB TITLE",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey[200]),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontSize: 16, color: ColorRes.textColor),
                      cursorColor: ColorRes.textColor,
                      controller: jobTitleCont,
                      
                      decoration: InputDecoration(
                        hintText: "Engineer",
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
              ) :
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LIVING",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey[200]),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontSize: 16, color: ColorRes.textColor),
                      cursorColor: ColorRes.textColor,
                      controller: livingCont,
                      
                      decoration: InputDecoration(
                        hintText: "NewYork, America",
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
              ) :
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ABOUT",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey[200]),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontSize: 16, color: ColorRes.textColor),
                      cursorColor: ColorRes.textColor,
                      controller: aboutCont,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "I'm foody and ...\nI love travelling...",
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
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    highlightedBorderColor: primaryColor,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text("MAN",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                  ColorRes.textColor,
                                  fontWeight: FontWeight.bold))),
                    ),
                    borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: man ? ColorRes.redButton : ColorRes.darkButton),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () {
                      setState(() {
                        woman = false;
                        man = true;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlineButton(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.width * .75,
                        child: Center(
                            child: Text("WOMAN",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ColorRes.textColor,
                                    fontWeight: FontWeight.bold))),
                      ),
                      borderSide: BorderSide(
                        color: woman ? ColorRes.redButton : ColorRes.darkButton,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: () {
                        setState(() {
                          woman = true;
                          man = false;
                        });
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => OTP()));
                      },
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
