import 'package:flutter/material.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  ProfileDetail userDetail;
  UserDetailsModel userDetailsModel = UserDetailsModel();

  int id;
  String name = '';
  String iAm = '';
  String sexualOrientation = '';
  String status = '';
  String livingIn = '';
  String jobTitle = '';
  String about = '';
  String dateOfBirth = '';

}
