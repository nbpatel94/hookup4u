import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/otp_verification.dart';
import 'package:hookup4u/util/color.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

bool cont = false;
String phoneNumber;

class _OTPState extends State<OTP> {
  @override
  @override
  void dispose() {
    super.dispose();
    cont = false;
  }

  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  "asset/auth/MobileNumber.png",
                  fit: BoxFit.cover,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              // Icon(
              //   Icons.mobile_screen_share,
              //   size: 50,
              // ),
              ListTile(
                title: Text(
                  "Verify Your Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  r"""Please enter Your mobile Number to
receive a verification code. Message and data 
rates may apply.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: primaryColor),
                          ),
                        ),
                        child: CountryCodePicker(
                          onChanged: print,
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'US',
                          favorite: ['+1', 'US'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),
                      ),
                      title: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 20),
                          cursorColor: primaryColor,
                          onChanged: (value) {
                            setState(() {
                              if (value.length == 10) {
                                cont = true;
                                phoneNumber = value;
                              } else {
                                cont = false;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your number",
                            focusColor: primaryColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                        ),
                      ))),
              cont
                  ? InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    primaryColor.withOpacity(.5),
                                    primaryColor.withOpacity(.8),
                                    primaryColor,
                                    primaryColor
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .75,
                          child: Center(
                              child: Text(
                            "CONTINUE",
                            style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Verification(phoneNumber)));
                      },
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            fontSize: 15,
                            color: darkPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
