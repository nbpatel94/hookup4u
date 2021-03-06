import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/match_model.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'edit_profile_viewmodel.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;


class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {

  EditProfileViewModel model;

  TextEditingController nameTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController genderTxt = TextEditingController();
  // TextEditingController dobTxt = TextEditingController();

  int currentDay;
  int currentMonth;
  int currentYear;
  String dateOfBirth = 'Date of birth';

  String _radioValue1 = '';
  String selectGender = '';
  int _radioValue = 0;

  File image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model ?? (model = EditProfileViewModel(this));

    // nameTxt.text = appState.currentUserData.data.displayName;

    // nameTxt.text = appState?.currentUserData?.data?.displayName != null && appState.currentUserData.data.displayName.isNotEmpty ?
    //               appState.currentUserData.data.displayName : appState.userDetailsModel.meta.name;

    if(appState?.userDetailsModel?.meta?.name != null && appState.userDetailsModel.meta.name.isNotEmpty) {
        nameTxt.text = appState.userDetailsModel.meta.name;
    } else {
        nameTxt.text = appState.currentUserData.data.displayName;
    }

    emailTxt.text = appState.currentUserData.data.email ?? "";
    dateOfBirth = appState?.userDetailsModel?.meta?.dateOfBirth ?? "";
    selectGender = appState?.userDetailsModel?.meta?.gender ?? "Male";

    if(selectGender == "Male") {
      selectGender = "Male";
      _radioValue = 0;
    } else {
      selectGender = "FeMale";
      _radioValue = 1;
    }
    setState(() {});
    // phoneTxt.text = appState.currentUserData.data.phone;
    // genderTxt.text = appState.currentUserData.data.;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (

      backgroundColor: ColorRes.primaryColor,

      appBar: AppBar(
        elevation: 0.0,
        actions: [
          InkResponse(
            onTap: () {
              model.editProfileUser();
              // model.updateUserDetails();
            },
            child: Center (
                child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text("Done", style: TextStyle(color: ColorRes.primaryRed)))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Edit Profile", style: TextStyle(color: ColorRes.white, fontSize: 30))),

            Container(
              height: 250,
              padding: EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                imageShow(),
                InkWell(
                    onTap: () {
                      if(!kIsWeb) {
                        source(context);
                      } else {
                        FocusScope.of(context).unfocus();
                        /*  WebImageSelection().selectImageWeb().then((value) {
                      // print(value);
                    });*/
                      }
                    },
                    child: Text("Change Profile Photo", style: TextStyle(color: ColorRes.primaryRed)))
              ]),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text("Username", style: TextStyle(color: ColorRes.greyBg))),
                  Expanded(
                    child: TextFormField (
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.right,
                      enableInteractiveSelection: false,
                      controller: nameTxt,
                    style: TextStyle(color: ColorRes.white),
                    decoration: decorationTextFiled("Darrell Bailey")
                    )
                  )
                ],
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [

                  Container(
                      width: 100,
                      child: Text("Email", style: TextStyle(color: ColorRes.greyBg))
                  ),

                  Expanded(
                      child: TextField (
                        controller: emailTxt,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: ColorRes.white),
                        decoration: decorationTextFiled("darrell_bailery@gmail.com"),
                      )
                  )

                ],
              ),
            ),

            // Container(
            //   height: 50,
            //   padding: EdgeInsets.only(left: 15, right: 15),
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     children: [
            //       Container(
            //           width: 100,
            //           child: Text("Phone", style: TextStyle(color: ColorRes.greyBg))),
            //       Expanded(
            //           child: TextField (
            //             controller: phoneTxt,
            //             textAlign: TextAlign.right,
            //             style: TextStyle(color: ColorRes.white),
            //             decoration: decorationTextFiled("+65 39879343"),
            //           ))
            //     ],
            //   ),
            // ),

            Container(
              height: 100,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 50,
                      margin: EdgeInsets.only(top: 15),
                      child: Text("Gender", style: TextStyle(color: ColorRes.greyBg))),
                  Container(
                    width: 150,
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: _radioValue,
                                  onChanged: (value) {
                                    selectGender = "Male";
                                    _radioValue = value;
                                    setState(() {});
                                  },
                                ),
                                new Text(
                                  'Male',
                                  style: new TextStyle(fontSize: 16.0, color: ColorRes.white)),
                                SizedBox(width: 17)
                              ]),
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
                     /* child: TextField (
                        controller: genderTxt,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: ColorRes.white),
                        decoration: decorationTextFiled("Female"),
                      )*/)
                ],
              ),
            ),

            Container (
              height: 40,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: Row (
                children: [
                  Container (
                      width: 100,
                      child: Text("Date of birth", style: TextStyle(color: ColorRes.greyBg))),
                  Expanded (
                    child: dateOfBirthDropDown(),
               /*       child: TextField (
                        onTap: () {
                          dateOfBirthDropDown();
                        },
                        controller: dobTxt,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: ColorRes.white),
                        decoration: decorationTextFiled("dd-mm-yyyy"),
                      )*/
                  )
                ],
              ),
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

  source(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text (
              "Select source",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  var _image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
                  if (_image != null) {
                    image = _image;
                    print("Image ${image.absolute.path}");
                    // model.uploadUseMedia();
                    model.updateUserProfile(image);
                    // model.updateUserProfile(image.readAsBytesSync());
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_camera,
                        size: 28,
                      ),
                      Text(
                        " Camera",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  File _image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                  if (_image != null) {
                    image = _image;
                    print("Image ${image.absolute.path}");
                    model.updateUserProfile(image);
                    Navigator.pop(context);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_library,
                        size: 28,
                      ),
                      Text(
                        " Gallery",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget dateOfBirthDropDown() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
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
              print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
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
      child: Container (
        height: 50,
        // padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 250,
        // margin: EdgeInsets.symmetric(vertical: 40),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 1, color: Colors.grey),
        //   borderRadius: BorderRadius.circular(4),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Text(
                dateOfBirth,
                style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.white, fontSize: 15),
              ),
            ),
            SizedBox(width: 5),
            Container(
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

  imageShow() {
    if(image != null && image.path.isNotEmpty) {
      return Center(
        child:  Container(
          height: 150,
          width: 150,
          // padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 10, top: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              shape: BoxShape.circle,
              image: DecorationImage(image: FileImage(image), fit: BoxFit.cover)
          ),
        ),
      );
    } else {
      return Center(
        child:  Container(
          height: 150,
          width: 150,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              shape: BoxShape.circle
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: appState.medialList!=null &&  appState.medialList.isNotEmpty ?
            CachedNetworkImage(
                imageUrl: appState.medialList[0].sourceUrl,
                placeholder: (context, url) => Image.asset(
                  'asset/Icon/placeholder.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                height: 150,
                width: 150,
                fit: BoxFit.contain
            ) : Image.asset(
              'asset/Icon/placeholder.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        /*child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                        alignment: Alignment.center,
                        height: 180,
                        width: 180,
                        image: AssetImage("asset/Icon/placeholder.png")),
                  ),*/
      );
    }
  }

}
