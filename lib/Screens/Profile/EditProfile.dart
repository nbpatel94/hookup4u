import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Gender.dart';
import 'package:hookup4u/Screens/Profile/profile.dart';
import 'package:hookup4u/Screens/SexualOrientation.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  TextEditingController livingCont = TextEditingController(text: appState.livingIn);
  TextEditingController jobTitleCont = TextEditingController(text: appState.jobTitle);
  TextEditingController aboutCont = TextEditingController(text: appState.about);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  snackbar(String text) {
    final snackBar = SnackBar(
      content: Text('$text ',style: TextStyle(color: ColorRes.white),textAlign: TextAlign.center,),
      backgroundColor: ColorRes.lightButton,
      duration: Duration(milliseconds: 1500),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(aboutCont.text.trim()==''){
          snackbar('Write something about you');
        } else if(jobTitleCont.text.trim()==''){
          snackbar('Write something about what do you do');
        } else if(livingCont.text.trim()==''){
          snackbar('Write where do you live');
        }else{
          appState.jobTitle = jobTitleCont.text.trim();
          appState.about = aboutCont.text.trim();
          appState.livingIn = livingCont.text.trim();
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        key: _scaffoldKey,
        appBar: AppBar(
            elevation: 0,
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                if(aboutCont.text.trim()==''){
                  snackbar('Write something about you');
                } else if(jobTitleCont.text.trim()==''){
                  snackbar('Write something about what do you do');
                } else if(livingCont.text.trim()==''){
                  snackbar('Write where do you live');
                }else{
                  appState.jobTitle = jobTitleCont.text.trim();
                  appState.about = aboutCont.text.trim();
                  appState.livingIn = livingCont.text.trim();
                  Navigator.pop(context);
                }
              },
            ),
            backgroundColor: primaryColor),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 1.5,
                        crossAxisSpacing: 4,
                        padding: EdgeInsets.all(10),
                        children: List.generate(9, (index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: currentUser.imageUrl.length > index
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            currentUser.imageUrl[index],
                                          )),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: secondryColor)),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        // width: 12,
                                        // height: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              currentUser.imageUrl.length > index
                                                  ? Colors.white
                                                  : primaryColor,
                                        ),
                                        child: currentUser.imageUrl.length > index
                                            ? InkWell(
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: primaryColor,
                                                  size: 22,
                                                ),
                                                onTap: () {
                                                  if (currentUser
                                                          .imageUrl.length >
                                                      1) {
                                                    setState(() {
                                                      currentUser.imageUrl
                                                          .removeAt(index);
                                                    });
                                                  } else {
                                                    source(context);
                                                  }
                                                },
                                              )
                                            : InkWell(
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 22,
                                                  color: Colors.white,
                                                ),
                                                onTap: () => source(context),
                                              )),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                  InkWell(
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
                                  primaryColor,
                                ])),
                        height: 50,
                        width: 340,
                        child: Center(
                            child: Text(
                          "Add media",
                          style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ))),
                    onTap: () {
                      source(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListBody(
                      mainAxis: Axis.vertical,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "About",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          subtitle: CupertinoTextField(
                            cursorColor: primaryColor,
                            controller: aboutCont,
                            maxLines: 10,
                            minLines: 3,
                            placeholder: "${appState.about}",
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Job title",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          subtitle: CupertinoTextField(
                            cursorColor: primaryColor,
                            controller: jobTitleCont,
                            placeholder: "${appState.jobTitle}",
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Living in",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          subtitle: CupertinoTextField(
                            cursorColor: primaryColor,
                            controller: livingCont,
                            placeholder: "${appState.livingIn}",
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        ListTile(
                            title: Text(
                              "I am",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black87),
                            ),
                            subtitle: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${appState.iAm}"),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Gender(generated: true,))),
                                ),
                              ),
                            )),
                        ListTile(
                            title: Text(
                              "Sexual Orientation",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black87),
                            ),
                            subtitle: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${appState.sexualOrientation}"),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SexualOrientation(generated: true,))),
                                ),
                              ),
                            )),
                        // ListTile(
                        //     title: Text(
                        //       "Control your profile",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //           color: Colors.black87),
                        //     ),
                        //     subtitle: Card(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: <Widget>[
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: <Widget>[
                        //               Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Text("Don't Show My Age"),
                        //               ),
                        //               Switch(
                        //                   activeColor: primaryColor,
                        //                   value: true,
                        //                   onChanged: (value) {
                        //                     value = !value;
                        //                   })
                        //             ],
                        //           ),
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: <Widget>[
                        //               Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Text("Make My Distance Visible"),
                        //               ),
                        //               Switch(
                        //                   activeColor: primaryColor,
                        //                   value: true,
                        //                   onChanged: (value) {
                        //                     value = !value;
                        //                   })
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
