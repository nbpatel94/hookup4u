import 'dart:convert';
import 'dart:io';

import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApi {
  static Future<String> signUpApi(String loginId, String name, String email, String password) async {
    String url = App.baseUrl + App.signUp;

    var bodyData = {
      "user_login": loginId,
      "user_email": email,
      "user_name": name,
      "password": password
    };

    var headerData = {
      "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYwNDAzMjkxMiwibmJmIjoxNjA0MDMyOTEyLCJleHAiOjE2MDQ2Mzc3MTIsImRhdGEiOnsidXNlciI6eyJpZCI6OX19fQ.ZcZuPd1EQtZnlwWlJ4fpEiuSU-R113pTaNqQAQFYHOg"
    };

    print(url);
    print(bodyData);
    print(headerData);

    try {
      Response response = await http.post(url,headers: headerData, body: bodyData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return 'success';
      } else {
        print(response.body);
        return jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      return 'Something went wrong! Please try later';
    }
  }

  static Future<String> logInApi(String loginId, String password) async {
    String url = App.loginBase;

    var bodyData = {"username": loginId, "password": password};

    print(url);
    print(bodyData);

    Response response = await http.post(url, body: bodyData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var userDetail = userDetailFromJson(response.body);
      if (userDetail.statusCode == 200) {
        appState.currentUserData = userDetail;
        appState.accessToken = userDetail.data.token;
        appState.id = userDetail.data.id;
        await sharedPreferences.setString(Preferences.profile, jsonEncode(userDetail.toJson()));
        await sharedPreferences.setString(Preferences.username, loginId);
        await sharedPreferences.setString(Preferences.password, password);
        await sharedPreferences.setString(Preferences.accessToken, userDetail.data.token);
        return 'success';
      } else {
        return userDetail.message;
      }
    } else {
      return 'Something went wrong! Please try later';
    }
  }

  static Future<String> requestVerificationCodeApi(String email) async {
    String url = App.baseUrl2 + App.reset_password;

    var bodyData = {"email": email};

    var headerData = {
      "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYwMzg2NTg0NSwibmJmIjoxNjAzODY1ODQ1LCJleHAiOjE2MDQ0NzA2NDUsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.sc9EMD37nM1SLakLt_gOtgjGH8ejLuRe5_jxEbwtaZo"
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = userDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    } else {
      print(response.body);
      return userDetail.message;
    }
  }

  static Future<String> verifyVerificationCodeApi(String email, String code) async {
    String url = App.baseUrl2 + App.validate_code;

    var bodyData = {"email": email, "code": code};

    var headerData = {
      "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYwMzg2NTg0NSwibmJmIjoxNjAzODY1ODQ1LCJleHAiOjE2MDQ0NzA2NDUsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.sc9EMD37nM1SLakLt_gOtgjGH8ejLuRe5_jxEbwtaZo"
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = userDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    } else {
      print(response.body);
      return userDetail.message;
    }
  }

  static Future<String> resetPasswordApi(String email, String password, String code,) async {
    String url = App.baseUrl2 + App.set_password;

    var bodyData = {"email": email, "password": password, "code": code};

    var headerData = {
      "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYwNDAzMjkxMiwibmJmIjoxNjA0MDMyOTEyLCJleHAiOjE2MDQ2Mzc3MTIsImRhdGEiOnsidXNlciI6eyJpZCI6OX19fQ.ZcZuPd1EQtZnlwWlJ4fpEiuSU-R113pTaNqQAQFYHOg"
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = userDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    } else {
      print(response.body);
      return userDetail.message;
    }
  }

  static Future<UserDetailsModel> getSingleUserDetails(int id) async {
    String url = App.baseUrlV2 + App.users + id.toString();

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    print(url);
    print(headerData);

    Response response = await http.get(url,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return userDetailsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<MediaModel>> getSingleUserMedia() async {
    String url = App.baseUrlV2 + App.media + '?author=${appState.id}';

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    print(url);
    print(headerData);

    Response response = await http.get(url,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return mediaListFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<ActivityModel>> getActivity() async {
    String url = App.baseUrlV2 + App.users;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    print(url);
    print(headerData);

    Response response = await http.get(url,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return activityModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<MediaModel> uploadUserMedia(File file) async {
    String url = App.baseUrlV2 + App.media;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}",
      "Content-Disposition" : "attachment; filename=user_image.jpg",
      "Content-Type":"image/png"
    };

    print(url);
    print(file.absolute.path);
    print(file.readAsBytesSync());
    print(headerData);

    try {
      Response response = await http.post(url,headers: headerData, body: file.readAsBytesSync());
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.body);
        return mediaModelFromJson(response.body);
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> deleteUserMedia(int id) async {
    String url = App.baseUrlV2 + App.media + '/$id?force=true';

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}",
    };

    print(url);
    print(headerData);

    try {
      Response response = await http.delete(url,headers: headerData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return 'success';
      } else {
        print(response.body);
        return '-';
      }
    } catch (e) {
      print(e);
      return '-';
    }
  }

  static Future<String> updateUserDetails(Map bodyData) async {
    String url = App.baseUrlV1 + App.user;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    print(url);
    print(bodyData);
    print(headerData);

    try {
      Response response = await http.post(url,headers: headerData, body: bodyData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return 'success';
      } else {
        print(response.body);
        return jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      return 'Something went wrong! Please try later';
    }
  }

  static Future getNotifications() async {
    String url = App.baseUrl + App.notifications;

    print(url);

    try {
      Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.toString() == '[]') {
          return null;
        } else {
          return response.body;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
