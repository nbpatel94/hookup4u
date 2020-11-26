import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hookup4u/Screens/auth/start_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/consumableStore.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'UpdateNumber.dart';

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
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: 'NeueFrutigerWorld',),
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
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Text(
            //     "Account settings",
            //     style: TextStyle(color: ColorRes.white,fontSize: 18, fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w500),
            //   ),
            // ),
            // ListTile(
            //   title: Card(
            //       color: ColorRes.darkButton,
            //       child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: InkWell(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text("Phone Number",style: TextStyle(color: ColorRes.textColor,fontFamily: 'NeueFrutigerWorld',),),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //               left: 80,
            //             ),
            //             child: Text(
            //               "1234567890",
            //               style: TextStyle(color: ColorRes.textColor,fontFamily: 'NeueFrutigerWorld',),
            //             ),
            //           ),
            //           Icon(
            //             Icons.arrow_forward_ios,
            //             color: ColorRes.textColor,
            //             size: 15,
            //           ),
            //         ],
            //       ),
            //       // onTap: () => Navigator.push(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //         builder: (context) => UpdateNumber())),
            //     ),
            //   )),
            //   subtitle:
            //       Text("Verify a phone number to secure your account",style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text(
            //     "Discovery settings",
            //     style: TextStyle(color: ColorRes.white,fontSize: 18,fontFamily: 'NeueFrutigerWorld', fontWeight: FontWeight.w500),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Card(
            //     color: ColorRes.darkButton,
            //     child: ExpansionTile(
            //       key: UniqueKey(),
            //       leading: Text("Location",style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),),
            //       trailing: Text(
            //         "Current location",
            //         style: TextStyle(
            //           color: Colors.blue,
            //           fontSize: 14,
            //           fontFamily: 'NeueFrutigerWorld',
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       title: Text(""),
            //       children: <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Icon(
            //                 Icons.location_on,
            //                 color: Colors.blue,
            //                 size: 25,
            //               ),
            //               Text(
            //                 "Add new location",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: Colors.blue,
            //                   fontSize: 16,
            //                   fontFamily: 'NeueFrutigerWorld',
            //                   fontWeight: FontWeight.w700,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 15,
            //   ),
            //   child: Text(
            //     "Change your location to see members in other city",
            //     style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     color: ColorRes.darkButton,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text(
            //             "Show me",
            //             style: TextStyle(
            //                 fontSize: 18,
            //                 color: ColorRes.textColor,
            //                 fontFamily: 'NeueFrutigerWorld',
            //                 fontWeight: FontWeight.w500),
            //           ),
            //           ListTile(
            //             title: DropdownButton(
            //               iconEnabledColor: ColorRes.textColor,
            //               iconDisabledColor: ColorRes.secondaryColor,
            //               isExpanded: true,
            //               items: [
            //                 DropdownMenuItem(
            //                   child: Text("Men",style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),),
            //                   value: "1",
            //                 ),
            //                 DropdownMenuItem(
            //                     child: Text("Women",style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,)), value: "2"),
            //                 DropdownMenuItem(
            //                     child: Text("Everyone",style: TextStyle(fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,)), value: "3"),
            //               ],
            //               onChanged: (val) {
            //                 setState(() {
            //                   _showMe = val;
            //                 });
            //               },
            //               value: _showMe,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     color: ColorRes.darkButton,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ListTile(
            //         title: Text(
            //           "Maximum distance",
            //           style: TextStyle(
            //               fontSize: 18,
            //               fontFamily: 'NeueFrutigerWorld',
            //               color: ColorRes.textColor,
            //               fontWeight: FontWeight.w500),
            //         ),
            //         trailing: Text(
            //           "$distance Km.",
            //           style: TextStyle(fontSize: 16,fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),
            //         ),
            //         subtitle: Slider(
            //             value: distance.toDouble(),
            //             inactiveColor: ColorRes.white,
            //             min: 1.0,
            //             max: 100.0,
            //             activeColor: ColorRes.primaryColor,
            //             onChanged: (val) {
            //               setState(() {
            //                 distance = val.round();
            //               });
            //             }),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     color: ColorRes.darkButton,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ListTile(
            //         title: Text(
            //           "Age range",
            //           style: TextStyle(
            //               fontSize: 18,
            //               fontFamily: 'NeueFrutigerWorld',
            //               color: ColorRes.textColor,
            //               fontWeight: FontWeight.w500),
            //         ),
            //         trailing: Text(
            //           "${ageRange.start.round()}-${ageRange.end.round()}",
            //           style: TextStyle(fontSize: 16,fontFamily: 'NeueFrutigerWorld',color: ColorRes.textColor,),
            //         ),
            //         subtitle: RangeSlider(
            //             inactiveColor: ColorRes.white,
            //             values: ageRange,
            //             min: 18.0,
            //             max: 100.0,
            //             divisions: 25,
            //             activeColor: ColorRes.primaryColor,
            //             labels: RangeLabels('${ageRange.start.round()}',
            //                 '${ageRange.end.round()}'),
            //             onChanged: (val) {
            //               setState(() {
            //                 ageRange = val;
            //               });
            //             }),
            //       ),
            //     ),
            //   ),
            // ),
            // ListTile(
            //   title: Text(
            //     "App settings",
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: ColorRes.white,),
            //   ),
            //   subtitle: Card(
            //     color: ColorRes.darkButton,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: <Widget>[
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               "Notifications",
            //               style: TextStyle(
            //                   fontSize: 18,
            //                   color: ColorRes.textColor,
            //                   fontWeight: FontWeight.w500),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text("Email",style: TextStyle(color: ColorRes.textColor,),),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text("Push notifications",style: TextStyle(color: ColorRes.textColor,),),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
                            fontSize: 15, fontWeight: FontWeight.w500, color: ColorRes.white,),
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
                              fontSize: 15, fontWeight: FontWeight.w700, color: ColorRes.white,),
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
                              fontSize: 15, fontWeight: FontWeight.w700, color: ColorRes.white,),
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
                              fontSize: 15, fontWeight: FontWeight.w700, color: ColorRes.white,),
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
                )),
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
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartScreen()),(Route<dynamic> route) => false);
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
                Text("${plan.toUpperCase()}",style: TextStyle(fontSize: 28),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("\$$price",style: TextStyle(fontSize: 18),),
                    Text(" / month",style: TextStyle(fontSize: 12),),
                  ],
                ),
              ],
            ),
            insetAnimationCurve: Curves.decelerate,
            content: plan == 'Gold' ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Text("- Unlimited Likes"),
                Text("- Rewind"),
                Text("- 5 Super Likes a day"),
                Text("- 1 Boost a month "),
                Text("- No ads"),
              ],
            ) : plan == 'Premium' ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Text("- See who Likes You"),
                Text("- New Top Picks every day"),
                Text("- Unlimited Likes"),
                Text("- Rewind"),
                Text("- 5 Super Likes a day"),
                Text("- 1 Boost a month "),
                Text("- No ads"),
              ],
            ): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Text("- See the Likes you’ve sent"),
                Text("- Have your Like prioritised"),
                Text("- New Top Picks every day"),
                Text("- See who Likes You"),
                Text("- Unlimited Likes"),
                Text("- Rewind"),
                Text("- 7 Super Likes a day"),
                Text("- 1 Boost a month "),
                Text("- No ads"),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  if(plan == 'Gold'){
                    // final PurchaseParam purchaseParam = PurchaseParam(productDetails: appState.products.where((element) => element.id==appState.productIds[0]).first);
                    // print(purchaseParam.productDetails.title);
                    // InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
                  }else if(plan == 'Premium'){
                    final PurchaseParam purchaseParam = PurchaseParam(productDetails: appState.products.where((element) => element.id==appState.productIds[1]).first);
                    print(purchaseParam.productDetails.title);
                    InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
                  }else{
                    final PurchaseParam purchaseParam = PurchaseParam(productDetails: appState.products.where((element) => element.id==appState.productIds[2]).first);
                    print(purchaseParam.productDetails.title);
                    InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
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
