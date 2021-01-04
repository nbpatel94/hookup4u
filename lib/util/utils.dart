

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  showToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

}
