import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/util/color.dart';
import 'package:intl/intl.dart';
import 'edit_profile_viewmodel.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

class EditWebProfilePage extends StatefulWidget {
  @override
  EditWebProfilePageState createState() => EditWebProfilePageState();
}

class EditWebProfilePageState extends State<EditWebProfilePage> {

  TextEditingController nameTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController genderTxt = TextEditingController();


  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  int currentDay;
  int currentMonth;
  int currentYear;
  String dateOfBirth = 'Date of birth';

  String _radioValue1 = '';
  String selectGender = '';
  int _radioValue = 0;


  bool isLoadingProfile = false;
  bool isLoadingPassword = false;
  EditProfileViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = EditProfileViewModel(this));

    nameTxt.text = appState?.userDetailsModel?.meta?.name != null && appState.userDetailsModel.meta.name.isNotEmpty ?
                   appState.userDetailsModel.meta.name : appState.currentUserData.data.displayName;
    emailTxt.text = appState.currentUserData.data.email ?? "";
    dateOfBirth = appState?.userDetailsModel?.meta?.dateOfBirth ?? "";

    if(appState?.userDetailsModel?.meta?.gender == "Male") {
      selectGender = "Male";
      _radioValue = 0;
    } else {
      selectGender = "FeMale";
      _radioValue = 1;
    }

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: ColorRes.primaryColor,
      key: _scaffoldKey,
      body: SingleChildScrollView (
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10),

            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding (
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

            Align (
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
                      margin: EdgeInsets.only(left: kIsWeb ? MediaQuery.of(context).size.height / 20 : 10, right: kIsWeb ? MediaQuery.of(context).size.height / 20 : 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container (
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Profile Settings", style: TextStyle(color: ColorRes.white, fontSize: 14)),
                                // Text("edit",  style: TextStyle(color: ColorRes.white, fontSize: 14)),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 1.6,
                            color: ColorRes.greyBg.withOpacity(0.5),
                            padding: EdgeInsets.only(top: 10),
                            margin: EdgeInsets.only(bottom: 15),
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
                                    controller: nameTxt,
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
                                    controller: emailTxt,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Email",
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
                                  // width: 100,
                                  padding: EdgeInsets.only(right: 10,left: 25),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Radio (
                                              value: 0,
                                              groupValue: _radioValue,
                                              onChanged: (value) {
                                                selectGender = "Male";
                                                _radioValue = value;
                                                setState(() {});
                                              },
                                            ),
                                            Text(
                                                'Male',
                                                style: new TextStyle(fontSize: 16.0, color: ColorRes.white)),
                                          ],
                                        ),


                                        SizedBox(width: 17),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _radioValue,
                                                onChanged: (value) {
                                                  selectGender = "Female";
                                                  _radioValue = value;
                                                  setState(() {});
                                                },
                                              ),
                                              Text('Female', style: new TextStyle(fontSize: 16.0, color: ColorRes.white)),
                                            ])
                                      ]),
                                ),

                                dateOfBirthDropDown(),

                                // Container(
                                //   margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                                //   padding: EdgeInsets.only(left: 10, right: 10),
                                //   decoration: BoxDecoration(
                                //       color: ColorRes.greyBg,
                                //       borderRadius: BorderRadius.circular(50)
                                //   ),
                                //   child: TextFormField(
                                //     keyboardType: TextInputType.emailAddress,
                                //     style: TextStyle(
                                //         fontSize: 16, color: ColorRes.white),
                                //     cursorColor: ColorRes.textColor,
                                //     // controller: emailCont,
                                //     decoration: InputDecoration(
                                //       hintText: "Email address",
                                //       hintStyle: TextStyle(
                                //           color: ColorRes.textColor, fontSize: 16),
                                //       focusColor: ColorRes.textColor,
                                //       border: InputBorder.none,
                                //       focusedBorder: InputBorder.none,
                                //       enabledBorder: InputBorder.none,
                                //       errorBorder: InputBorder.none,
                                //       disabledBorder: InputBorder.none,
                                //       // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                                //       // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.textColor)),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                                //   padding: EdgeInsets.only(left: 10, right: 10),
                                //   decoration: BoxDecoration(
                                //       color: ColorRes.greyBg,
                                //       borderRadius: BorderRadius.circular(50)
                                //   ),
                                //   child: TextFormField(
                                //     style: TextStyle(
                                //         fontSize: 16, color: ColorRes.white),
                                //     cursorColor: ColorRes.textColor,
                                //     // controller: passwordCont,
                                //     obscureText: true,
                                //     decoration: InputDecoration(
                                //       hintText: "Password",
                                //       hintStyle: TextStyle(
                                //           color: ColorRes.textColor, fontSize: 16),
                                //       focusColor: ColorRes.textColor,
                                //       border: InputBorder.none,
                                //       focusedBorder: InputBorder.none,
                                //       enabledBorder: InputBorder.none,
                                //       errorBorder: InputBorder.none,
                                //       disabledBorder: InputBorder.none,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {


                                    if (!isLoadingProfile) {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                                      if (model.validate()) {
                                        setState(() {
                                          isLoadingProfile = true;
                                        });
                                        model.editProfileUser();
                                        // model.signUp();
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    // height: MediaQuery.of(context).size.height * .075,
                                    // width: MediaQuery.of(context).size.width / 3.5,
                                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.redButton,
                                    ),
                                    child: Center(
                                        child: isLoadingProfile
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

                Expanded (
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: kIsWeb ? MediaQuery.of(context).size.height / 20 : 10, right: kIsWeb ? MediaQuery.of(context).size.height / 20 : 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container (
                            height: 50,
                            child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Change Password", style: TextStyle(color: ColorRes.white, fontSize: 14)),
                                // Text("edit",  style: TextStyle(color: ColorRes.white, fontSize: 14)),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2.0,
                            color: ColorRes.greyBg.withOpacity(0.5),
                            padding: EdgeInsets.only(top: 10),
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
                                    controller: currentPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Current Password",
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
                                    controller: password,
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
                                    controller: conformPassword,
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

                                    if (!isLoadingPassword) {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: emailCont.text.trim())));
                                      if (model.passwordMatch()) {
                                        setState(() {
                                          isLoadingPassword = true;
                                        });
                                        model.changePassword();
                                      }
                                    }

                                  },
                                  child: Container(
                                    height: 50,
                                    // height: MediaQuery.of(context).size.height * .075,
                                    // width: MediaQuery.of(context).size.width / 3.5,
                                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.redButton,
                                    ),
                                    child: Center(
                                        child: isLoadingPassword
                                            ? Padding(
                                            child: CircularProgressIndicator (
                                              backgroundColor: ColorRes.primaryColor,
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



  decorationTextFiled(String hintText) {
    return InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
      hintText: hintText,
      hintStyle: TextStyle(color: ColorRes.greyBg),
      alignLabelWithHint: true,

    );
  }

  Widget dateOfBirthDropDown() {
    return GestureDetector (
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1960, 1, 1),
            maxTime: DateTime.now(),
            theme: DatePickerTheme(
                headerColor: ColorRes.darkButton,
                backgroundColor: ColorRes.primaryColor,
                itemStyle: TextStyle(
                    color: ColorRes.textColor,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                cancelStyle: TextStyle(color: ColorRes.textColor, fontSize: 16),
                doneStyle: TextStyle(color: ColorRes.textColor, fontSize: 16)),
            onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          currentDay = date.day;
          currentYear = date.year;
          currentMonth = date.month;
          // dateOfBirth  = '${date.day}/${date.month}/${date.year}';
          // print("Hello " + dateOfBirth);

          // final DateTime now = DateTime.now();
          final DateFormat formatter = DateFormat('MMM dd, y');
          final String formatted = formatter.format(date);
          print("confirm" + formatted);

          dateOfBirth = formatted;

          print('confirm $dateOfBirth');
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
      child: Container(
        height: 50,
        // padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width / 0.5,
        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
        decoration: BoxDecoration (
          color: ColorRes.greyBg,
          borderRadius: BorderRadius.circular(50)
        ),
        // margin: EdgeInsets.symmetric(vertical: 40),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 1, color: Colors.grey),
        //   borderRadius: BorderRadius.circular(4),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                dateOfBirth,
                style: TextStyle(
                    fontFamily: 'NeueFrutigerWorld',
                    color: ColorRes.white,
                    fontSize: 15),
              ),
            ),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: Colors.grey,
              ),
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
      duration: Duration(seconds: 10),
    ));
  }


}


