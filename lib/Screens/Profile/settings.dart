import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hookup4u/Screens/auth/start_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/consumableStore.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'UpdateNumber.dart';
import 'package:hookup4u/Screens/Splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/prefrences.dart';
import 'dart:convert';

int distance = 10;
var ageRange = RangeValues(18, 30);
var _showMe = "2";

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'NeueFrutigerWorld',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: ColorRes.primaryColor),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: ColorRes.darkButton,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      "Invite your friends",
                      style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                source();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: ColorRes.darkButton,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: ColorRes.darkButton,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    planDialogue("Gold", 7.99);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: ColorRes.gold,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Gold\n\$7.99",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    planDialogue("Premium", 19.99);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: ColorRes.platinum,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Premium\n\$19.99",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    planDialogue("Plus+", 49.99);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: ColorRes.plus,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Plus+\n\$49.99",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                    height: 80,
                    // width: 100,
                    child: Image.asset(
                      "asset/Icon/icon_dark.png",
                      fit: BoxFit.contain,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  source() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Are you sure you want to logout?",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  await sharedPreferences.clear();
                  await databaseHelper.clearMessageDatabase();
                  appState.medialList.clear();
                  appState.userDetailsModel = null;
                  appState.currentUserData = null;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.redButton,
                  child: Text(
                    "YES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.darkButton,
                  child: Text(
                    "NO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          );
        });
  }

  planDialogue(String plan, double price) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: [
                Text(
                  "${plan.toUpperCase()}",
                  style: TextStyle(fontSize: 28),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$$price",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      " / month",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            insetAnimationCurve: Curves.decelerate,
            content: plan == 'Gold'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Text("- Unlimited Likes"),
                      Text("- 5 Super Likes a day"),
                      Text("- No ads"),
                    ],
                  )
                : plan == 'Premium'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Text("- See who Likes You"),
                          Text("- Unlimited Likes"),
                          Text("- 5 Super Likes a day"),
                          Text("- No ads"),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Text("- See the Likes you’ve sent"),
                          Text("- Have your Like prioritised"),
                          Text("- See who Likes You"),
                          Text("- Unlimited Likes"),
                          Text("- 7 Super Likes a day"),
                          Text("- No ads"),
                        ],
                      ),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  // if (plan == 'Gold') {
                  //   final PurchaseParam purchaseParam = PurchaseParam(
                  //       productDetails: appState.products
                  //           .where((element) =>
                  //               element.id == appState.productIds[0])
                  //           .first);
                  //   print(purchaseParam.productDetails.title);
                  //   InAppPurchaseConnection.instance
                  //       .buyConsumable(purchaseParam: purchaseParam);
                  // }
                  // else if (plan == 'Premium') {
                  //   final PurchaseParam purchaseParam = PurchaseParam(
                  //       productDetails: appState.products
                  //           .where((element) =>
                  //               element.id == appState.productIds[1])
                  //           .first);
                  //   print(purchaseParam.productDetails.title);
                  //   InAppPurchaseConnection.instance
                  //       .buyConsumable(purchaseParam: purchaseParam);
                  // }
                  // else {
                  //   final PurchaseParam purchaseParam = PurchaseParam(
                  //       productDetails: appState.products
                  //           .where((element) =>
                  //               element.id == appState.productIds[2])
                  //           .first);
                  //   print(purchaseParam.productDetails.title);
                  //   InAppPurchaseConnection.instance
                  //       .buyConsumable(purchaseParam: purchaseParam);
                  // }

                  print(DateTime.now());

                  if (plan == 'Gold') {
                    print("Buying Gold Subscription");
                    EasyLoading.show();

                    appState.subscriptionName = appState.productIds[0];
                    appState.subscriptionDate = DateTime.now();
                    appState.userDetailsModel.meta.subscriptionName = appState.subscriptionName;
                    appState.userDetailsModel.meta.subscriptionDate = appState.subscriptionDate;

                    print(appState.userDetailsModel.meta.toJson());
                    await sharedPreferences.setString(Preferences.metaData, jsonEncode(appState.userDetailsModel.toJson()));

                    await Future.delayed(Duration(seconds: 5));
                    EasyLoading.dismiss();
                    Navigator.pushAndRemoveUntil(
                        this.context,
                        MaterialPageRoute(builder: (context) => Splash()),
                        (Route<dynamic> route) => false);
                  } else if (plan == 'Premium') {
                    print("Buying Premium Subscription");
                    EasyLoading.show();

                    appState.subscriptionName = appState.productIds[1];
                    appState.subscriptionDate = DateTime.now();
                    appState.userDetailsModel.meta.subscriptionDate = appState.subscriptionDate;
                    appState.userDetailsModel.meta.subscriptionName = appState.subscriptionName;

                    print(appState.userDetailsModel.meta.toJson());
                    await sharedPreferences.setString(Preferences.metaData, jsonEncode(appState.userDetailsModel.toJson()));

                    await Future.delayed(Duration(seconds: 5));
                    EasyLoading.dismiss();
                    Navigator.pushAndRemoveUntil(
                        this.context,
                        MaterialPageRoute(builder: (context) => Splash()),
                            (Route<dynamic> route) => false);
                  } else {
                    print("Buying Plus+ Subscription");
                    EasyLoading.show();

                    appState.subscriptionName = appState.productIds[2];
                    appState.subscriptionDate = DateTime.now();
                    appState.userDetailsModel.meta.subscriptionDate = appState.subscriptionDate;
                    appState.userDetailsModel.meta.subscriptionName = appState.subscriptionName;

                    print(appState.userDetailsModel.meta.toJson());
                    await sharedPreferences.setString(Preferences.metaData, jsonEncode(appState.userDetailsModel.toJson()));

                    await Future.delayed(Duration(seconds: 5));
                    EasyLoading.dismiss();
                    Navigator.pushAndRemoveUntil(
                        this.context,
                        MaterialPageRoute(builder: (context) => Splash()),
                            (Route<dynamic> route) => false);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.darkButton,
                  child: Text(
                    "SUBSCRIBE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
