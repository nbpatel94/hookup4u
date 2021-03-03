import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/Splash.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/web_view/about_as/about_us_screen.dart';
import 'package:hookup4u/web_view/edit_profile_view/edit_profile_screen.dart';
import 'package:hookup4u/web_view/home_view/home_screen.dart' as webView;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/auth/start_screen.dart';
import 'app.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'dart:io' show Platform;

import 'web_view/edit_profile_view/edit_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };

  if (!kIsWeb) {
    print("Not WEb");
    await Firebase.initializeApp();
    InAppPurchaseConnection.enablePendingPurchases();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]).then((_) {
      SharedPreferences.getInstance().then((prefs) {
        sharedPreferences = prefs;
        runApp(MyApp());
      });
    });
  } else {
    print("Web.......");
    SharedPreferences.getInstance().then((prefs) {
      sharedPreferences = prefs;
      runApp(MyApp());
    });
    runApp(MyApp());
    /*  SharedPreferences.getInstance().then((prefs) {
      sharedPreferences = prefs;
    });*/
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 100
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    // ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorRes.primaryColor,
        textTheme: Theme.of(context).textTheme.copyWith(
            body1: Theme.of(context).textTheme.body1.apply(color: Colors.white),
            // body2: Theme.of(context).textTheme.body2.apply(color: Colors.white),
            // display1: Theme.of(context).textTheme.display1.apply(color: Colors.white),
            // display2: Theme.of(context).textTheme.display2.apply(color: Colors.white),
            // ... // and so on
        ),
      ),
      // home:  EditWebProfilePage() ,
      // home: kIsWeb ? EditWebProfilePage() : Splash(),
      home: kIsWeb ? webView.HomePage() : Splash(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
