import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/start_screen.dart';
import 'package:hookup4u/Screens/home/list_holder_page.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/consumableStore.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  getSharedDetails() async {
    await initStoreInfo();

    if (sharedPreferences.containsKey(Preferences.accessToken)) {
      print("FCM --> ${sharedPreferences.getString("token")}");
      appState.accessToken = sharedPreferences.getString(Preferences.accessToken);
      appState.currentUserData = profileDetailFromJson(sharedPreferences.getString(Preferences.profile));
      if (sharedPreferences.containsKey(Preferences.metaData)) {
        print("meta contain");

        UserDetailsModel userDetailsModel = userDetailsModelFromJson(sharedPreferences.getString(Preferences.metaData));

        appState.superLikeTime = DateTime.parse(sharedPreferences.getString(Preferences.superLikeTime));
        appState.superLikeCount = sharedPreferences.getInt(Preferences.superLikeCount);
        appState.likeCount = sharedPreferences.getInt(Preferences.likeCount);
        appState.likeTime = DateTime.parse(sharedPreferences.getString(Preferences.likeTime));

        print("Superlike Count -> ${appState.superLikeCount} Superlike time -> ${appState.superLikeTime}");
        print("Like Count -> ${appState.likeCount} Like time -> ${appState.likeTime}");
        print("SuperLike -> ${DateTime.now().difference(appState.superLikeTime).inMinutes} Like -> ${DateTime.now().difference(appState.likeTime).inMinutes}");

        appState.subscriptionName = userDetailsModel?.meta?.subscriptionName ?? "";
        appState.subscriptionDate = userDetailsModel?.meta?.subscriptionDate ?? null;

        // if(DateTime.now().difference(appState.superLikeTime).inMinutes>=10 && appState.superLikeCount==0){
        //   if(appState.subscriptionDate!=null && appState.subscriptionDate.month==0) {
        //     appState.superLikeCount = 5;
        //   }else{
        //     appState.superLikeCount = 1;
        //   }
        // }
        // if(DateTime.now().difference(appState.likeTime).inMinutes>=10 && appState.likeCount==0){
        //   appState.likeCount = 30;
        // }

        // appState.subscriptionName = userDetailsModel.meta.subscriptionName;
        // appState.subscriptionDate = userDetailsModel.meta.subscriptionDate;

        print("Subscription Name: ${appState.subscriptionName}");
        print("Subscription Date: ${appState.subscriptionDate}");

        appState.userDetailsModel = userDetailsModel;
        appState.children = userDetailsModel?.meta?.children ?? "";
        appState.gender = userDetailsModel?.meta?.gender ?? "";
        appState.relation = userDetailsModel?.meta?.relation ?? "";
        appState.livingIn = userDetailsModel?.meta?.livingIn ?? "";
        appState.jobTitle = userDetailsModel?.meta?.jobTitle ?? "";
        appState.about = userDetailsModel?.meta?.about ?? "";
        appState.id = userDetailsModel?.id != "null" ?int.parse(userDetailsModel?.id ?? "") : 27;
        // appState.id = int.parse(userDetailsModel.id);

        print(userDetailsModel?.meta?.toFirstJson());
        if (sharedPreferences.containsKey(Preferences.mediaData)) {
          print("media contain");
          List<MediaModel> mediaList = mediaListFromJson(
              sharedPreferences.getString(Preferences.mediaData));
          appState.medialList = mediaList;
          print('Current User : ${appState.id}');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          });
        } else {
          print("media !contain");
          final medialList = await RestApi.getSingleUserMedia();
          if (medialList != null) {
            appState.medialList = medialList;
            await sharedPreferences.setString(
                Preferences.mediaData, mediaListToJson(medialList));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListHolderPage()));
          }
        }
      } else {
        print("meta !contain");
        Future.delayed(Duration(seconds: 4), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StartScreen()));
        });
      }
    } else {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartScreen()));
      });
    }
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  SharedPreferences sp;

  void firebaseTokenListening() async {
    sp = await SharedPreferences.getInstance();
    if (!sp.containsKey("token")) {
      if (Platform.isIOS) iOS_Permission();

      _firebaseMessaging.getToken().then((token) {
        print("fcm : $token");
        sp.setString('token', token);
        // RestApi.addFCMToken(token);
      });
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.primaryColor,
        body: Center(
          child: Container(
              height: 150,
              width: 230,
              child: Platform.isIOS ? Image.asset("asset/Icon/logo_white.png") : SvgPicture.asset(
                "asset/ihr-mus-clear-bg.svg",
                fit: BoxFit.contain,
              )
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      firebaseTokenListening();
    }

    getSharedDetails();
  }

  /// inAppPurchase

  InAppPurchaseConnection _connection;

  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  Future<void> initStoreInfo() async {
    _connection = InAppPurchaseConnection.instance;

    final bool isAvailable = await _connection.isAvailable();
    print("inAppPurchase avail $isAvailable");
    if (!isAvailable) {
      // setState(() {
      _isAvailable = isAvailable;
      _products = [];
      appState.products = [];
      _purchases = [];
      _notFoundIds = [];
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    Stream purchaseUpdated = _connection.purchaseUpdatedStream;
    purchaseUpdated.listen((purchaseDetailsList) {
      print(purchaseDetailsList.length);
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      print("Listening Done");
      _subscription.cancel();
    }, onError: (error) {
      print("inAppPurchase error: $error");
    });

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(appState.productIds.toSet());
    productDetailResponse.productDetails.forEach((element) {
      print("inAppPurchase ${element.title} -- ${element.price}");
    });
    if (productDetailResponse.error != null) {
      // setState(() {
      _queryProductError = productDetailResponse.error.message;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      appState.products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      // setState(() {
      _queryProductError = null;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      appState.products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    await subscriptionStatus();

    print("Status Done");

    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      appState.products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  // Future<void> consume(String id) async {
  //   await ConsumableStore.consume(id);
  //   final List<String> consumables = await ConsumableStore.load();
  //   print("inAppPurchase consumables $consumables");
  //   setState(() {
  //     _consumables = consumables;
  //   });
  // }
  //
  // void showPendingUI() {
  //   setState(() {
  //     _purchasePending = true;
  //   });
  // }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    /// IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    print("Delivering");
    // setState(() {
    _purchases.add(purchaseDetails);
    _purchasePending = false;
    // });

    // USER META UPDATE IN API
    String check = await RestApi.updateUserDetails({
      'id': appState.id,
      'subscription_name': purchaseDetails.productID,
      'subscription_date': purchaseDetails.transactionDate
    });
    if (check == 'success') {
      appState.subscriptionName = purchaseDetails.productID;
      appState.subscriptionDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(purchaseDetails.transactionDate));
      appState.userDetailsModel.meta.subscriptionDate =
          appState.subscriptionDate;
      appState.userDetailsModel.meta.subscriptionName =
          appState.subscriptionName;

      print(appState.userDetailsModel.meta.toJson());
      await sharedPreferences.setString(
          Preferences.metaData, jsonEncode(appState.userDetailsModel.toJson()));

      // EasyLoading.dismiss();
      getSharedDetails();
    }
  }

  void handleError(IAPError error) {
    print("inAppPurchase IAPError ${error.message} -- ${error.details}");
    Navigator.pop(appState.settingContext);
    source();
    // setState(() {
    _purchasePending = false;
    // });
  }

  source() {
    return showDialog(
        context: appState.settingContext,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Something went wrong! your purchase is not verified! if you paid then please wait for sometime and check again",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.redButton,
                  child: Text(
                    "OKAY",
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

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    print("Verifying");
    print(
        "inAppPurchase purchaseDetails ${DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate))}");
    print("inAppPurchase purchaseDetails ${purchaseDetails.productID}");
    print("inAppPurchase purchaseDetails ${purchaseDetails.status}");
    if (purchaseDetails != null &&
        purchaseDetails.purchaseID != null &&
        purchaseDetails.purchaseID.isNotEmpty &&
        purchaseDetails.status == PurchaseStatus.purchased) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print("inAppPurchase purchaseResponse error ${purchaseDetails.error.message} -- ${purchaseDetails.error.code} -- ${purchaseDetails.error.details}");
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print("Listening");
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("inAppPurchase purchaseDetails.status ${purchaseDetails.status}");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("inAppPurchase purchaseDetails.status ${purchaseDetails.status}");
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          print("inAppPurchase purchaseDetails.status ${purchaseDetails.status}");
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  subscriptionStatus() async {
    if (Platform.isIOS) {
      final QueryPurchaseDetailsResponse purchaseResponse =
          await _connection.queryPastPurchases();
      if (purchaseResponse.error != null) {
        print(
            "inAppPurchase purchaseResponse error ${purchaseResponse.error.message} -- ${purchaseResponse.error.code} -- ${purchaseResponse.error.details}");
      }

      var history = purchaseResponse.pastPurchases;
      final List<PurchaseDetails> verifiedPurchases = [];

      for (var purchase in history) {
        Duration difference = DateTime.now().difference(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(purchase.transactionDate)));
        if (difference.inMinutes <= (Duration(days: 30)).inMinutes &&
            purchase.status == PurchaseStatus.purchased) {
          print("--------");
          print("inAppPurchase purchaseDetails ${difference.inMinutes}");
          print("inAppPurchase purchaseDetails ${purchase.productID}");
          verifiedPurchases.add(purchase);
        }
      }
      _purchases = verifiedPurchases;
      if (_purchases.isNotEmpty) {
        appState.subscriptionName = _purchases[0].productID;
        appState.subscriptionDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(_purchases[0].transactionDate));
        appState.userDetailsModel.meta.subscriptionDate =
            appState.subscriptionDate;
        appState.userDetailsModel.meta.subscriptionName =
            appState.subscriptionName;

        print(appState.userDetailsModel.meta.toJson());
        await sharedPreferences.setString(Preferences.metaData,
            jsonEncode(appState.userDetailsModel.toJson()));
      }
    } else if (Platform.isAndroid) {
      final QueryPurchaseDetailsResponse purchaseResponse =
          await _connection.queryPastPurchases();
      if (purchaseResponse.error != null) {
        print(
            "inAppPurchase purchaseResponse error ${purchaseResponse.error.message} -- ${purchaseResponse.error.code} -- ${purchaseResponse.error.details}");
      }
      final List<PurchaseDetails> verifiedPurchases = [];
      for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
        if (await _verifyPurchase(purchase)) {
          verifiedPurchases.add(purchase);
        }
      }
      _purchases = verifiedPurchases;
      if (_purchases.isNotEmpty) {
        appState.subscriptionName = _purchases[0].productID;
        appState.subscriptionDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(_purchases[0].transactionDate));
        appState.userDetailsModel.meta.subscriptionDate =
            appState.subscriptionDate;
        appState.userDetailsModel.meta.subscriptionName =
            appState.subscriptionName;

        print(appState.userDetailsModel.meta.toJson());
        await sharedPreferences.setString(Preferences.metaData,
            jsonEncode(appState.userDetailsModel.toJson()));
      }
    }
  }
}
