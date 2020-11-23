import 'package:flutter/material.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  ProfileDetail currentUserData;
  UserDetailsModel userDetailsModel = UserDetailsModel();
  List<MediaModel> medialList;
  List<ProductDetails> products = [];
  List<String> productIds = <String>['gold_sub', 'premium_sub', 'plus_sub'];

  int id;
  String accessToken = '';
  String name = '';
  String gender = '';

  // USER META
  String relation = '';
  String children = '';
  String livingIn = '';
  String jobTitle = '';
  String about = '';
  String dateOfBirth = '';
}
