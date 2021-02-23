import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'edit_profile_viewmodel.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {

  EditProfileViewModel model;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = EditProfileViewModel(this));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10),

            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 25, top: 15),
                    child: Icon(Icons.arrow_back, color: ColorRes.white, size: 25))),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('asset/Icon/icon_dark.png')
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Divider(
                height: 2,
                color: ColorRes.white,
              ),
            ),

            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text("My Account Dashboard", style: TextStyle(fontSize: 25, color: ColorRes.white))),
            ),

            Row(
              children: [

                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Profile Settings", style: TextStyle(color: ColorRes.white, fontSize: 14)),
                                Text("edit",  style: TextStyle(color: ColorRes.white, fontSize: 14)),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            color: ColorRes.greyBg.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                    // controller: userIdCont,
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
                                    // controller: userNameCont,
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
                                    // controller: emailCont,
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
                                    // controller: passwordCont,
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
                                    /*if (!isLoading) {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                                      if (model.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        model.signUp();
                                      }
                                    }*/
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
                                            : Text("changes profile",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'NeueFrutigerWorld',
                                                fontWeight: FontWeight.w700))),
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    )
                ),

                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Change Password", style: TextStyle(color: ColorRes.white, fontSize: 14)),
                                Text("edit",  style: TextStyle(color: ColorRes.white, fontSize: 14)),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3,
                            color: ColorRes.greyBg.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                    // controller: passwordCont,
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
                                    // controller: passwordCont,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Conform Password",
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
                                    /*if (!isLoading) {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                                      if (model.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        model.signUp();
                                      }
                                    }*/
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
                                            : Text("Update password",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'NeueFrutigerWorld',
                                                fontWeight: FontWeight.w700))),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ))

              ],
            )

          ],
        ),
      ),

    );
  }
}


