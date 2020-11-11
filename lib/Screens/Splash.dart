import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  getSharedDetails() async {
    if(sharedPreferences.containsKey(Preferences.accessToken)){
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartScreen()));
      });
    }
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
    getSharedDetails();

    /// inAppPurchase initialization

    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print("inAppPurchase error: $error");
    });
    initStoreInfo();
  }

  /// inAppPurchase

  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  bool _kAutoConsume = true;

  String _kConsumableId = 'consumable';
  List<String> _kProductIds = <String>[
    'consumable',
    'upgrade',
    'subscription'
  ];

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    print("inAppPurchase avail $_isAvailable");
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(_kProductIds.toSet());
    print("inAppPurchase productDetailResponse ${productDetailResponse.productDetails.asMap()}");
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      print("inAppPurchase productDetails ${productDetailResponse.productDetails}");
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
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
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    print("inAppPurchase consumables $consumables");
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID);
      List<String> consumables = await ConsumableStore.load();
      print("inAppPurchase consumables $consumables");
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
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
    print("inAppPurchase purchaseDetails ${purchaseDetails.purchaseID}");
    print("inAppPurchase purchaseDetails ${purchaseDetails.productID}");
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print("inAppPurchase purchaseDetails error ${purchaseDetails.error}");
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("inAppPurchase purchaseDetails.status ${purchaseDetails.status}");
        showPendingUI();
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
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }
}
