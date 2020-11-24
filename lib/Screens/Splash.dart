import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  getSharedDetails() async {
    await initStoreInfo();
    if(sharedPreferences.containsKey(Preferences.accessToken)){
      print("FCM --> ${sharedPreferences.getString("token")}");
      appState.accessToken = sharedPreferences.getString(Preferences.accessToken);
      appState.currentUserData = profileDetailFromJson(sharedPreferences.getString(Preferences.profile));
      if(sharedPreferences.containsKey(Preferences.metaData)){
        print("meta contain");
        UserDetailsModel userDetailsModel = userDetailsModelFromJson(sharedPreferences.getString(Preferences.metaData));
        appState.userDetailsModel = userDetailsModel;
        appState.children = userDetailsModel.meta.children;
        appState.gender = userDetailsModel.meta.gender;
        appState.relation = userDetailsModel.meta.relation;
        appState.livingIn = userDetailsModel.meta.livingIn;
        appState.jobTitle = userDetailsModel.meta.jobTitle;
        appState.about = userDetailsModel.meta.about;
        appState.id = userDetailsModel.id;
        // print(userDetailsModel.meta.toJson());
        if(sharedPreferences.containsKey(Preferences.mediaData)){
          print("media contain");
          List<MediaModel> mediaList = mediaListFromJson(sharedPreferences.getString(Preferences.mediaData));
          appState.medialList = mediaList;
          print('Current User : ${appState.id}');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          });
        }
        else{
          print("media !contain");
          final medialList = await RestApi.getSingleUserMedia();
          if(medialList!=null){
            appState.medialList = medialList;
            await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          }
        }
      }
      else{
        print("meta !contain");
        UserDetailsModel userDetailsModel = await RestApi.getSingleUserDetails(appState.id);
        if(userDetailsModel!=null && userDetailsModel.meta.about!=""){
          appState.userDetailsModel = userDetailsModel;
          appState.children = userDetailsModel.meta.children;
          appState.relation = userDetailsModel.meta.relation;
          appState.livingIn = userDetailsModel.meta.livingIn;
          appState.jobTitle = userDetailsModel.meta.jobTitle;
          appState.about = userDetailsModel.meta.about;
          print(userDetailsModel.meta.toJson());
          await sharedPreferences.setString(Preferences.metaData, jsonEncode(userDetailsModel.toJson()));
          final medialList = await RestApi.getSingleUserMedia();
          if(medialList!=null){
            appState.medialList = medialList;
            await sharedPreferences.setString(Preferences.mediaData, mediaListToJson(medialList));
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListHolderPage()));
          }
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
        }
      }
    }else{
      Future.delayed(Duration(seconds: 4), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreen()));
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
        print(token);
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
              height: 120,
              width: 200,
              child: SvgPicture.asset(
                "asset/ihr-mus-clear-bg.svg",
                fit: BoxFit.contain,
              )),
        ));
  }

  @override
  void initState() {
    super.initState();
    firebaseTokenListening();
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
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        appState.products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    Stream purchaseUpdated = _connection.purchaseUpdatedStream;
    purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
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
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        appState.products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        appState.products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse = await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      print("inAppPurchase purchaseResponse error ${purchaseResponse.error}");
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    print("inAppPurchase consumables $consumables");
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      appState.products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
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
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });

    // USER META UPDATE IN API
    String check = await RestApi.updateUserDetails({
      'subscription_name' : purchaseDetails.productID,
      'subscription_date' : DateTime.now().toIso8601String()
    });
    if (check == 'success') {
      Navigator.pop(context);
    }
  }

  void handleError(IAPError error) {
    print("inAppPurchase IAPError $error");
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    print("Verifying");
    print("inAppPurchase purchaseDetails ${purchaseDetails.purchaseID}");
    print("inAppPurchase purchaseDetails ${purchaseDetails.productID}");
    if(purchaseDetails!=null && purchaseDetails.purchaseID!=null && purchaseDetails.purchaseID.isNotEmpty){
      return Future<bool>.value(true);
    }else{
      return Future<bool>.value(false);
    }

  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print("inAppPurchase purchaseDetails error ${purchaseDetails.error}");
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
        }
        else if (purchaseDetails.status == PurchaseStatus.purchased) {
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
          await InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }
}
