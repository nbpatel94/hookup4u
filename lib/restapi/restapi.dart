import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/auth/verify_otp_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:hookup4u/models/profile_detail.dart';
import 'package:hookup4u/models/thread_list_model.dart' as thread;
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/models/user_detail_model.dart';
import 'package:hookup4u/prefrences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';

class RestApi {

/*  Future<Map<String, dynamic>> getFacebookDetails(String url) async {
    bool isConnect = await isConnectNetworkWithMessage(_context);
    if (!isConnect) return null;
    http.Response response = await http.get(url);
    String data = response.body;
    return jsonDecode(data);
  }

  Future<bool> isConnectNetworkWithMessage(BuildContext context) async {
    // var connectivityResult = await connectivity.checkConnectivity();
    bool isConnect = getConnectionValue(connectivityResult);
    if (!isConnect) {
      commonMessage(
        context,
        "Network connection required to fetch data.",
      );
    }
    return isConnect;
  }*/

  static Future<String> signUpApi(String loginId, String name, String email, String password) async {
    String url = App.baseUrl + App.signUp;

    var bodyData = {
      "user_login": loginId,
      "user_email": email,
      "user_name": name,
      "password": password
    };

    var headerData = {
      "Authorization" : "Bearer "+App.adminToken
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

  static Future<String> logInApi(String loginId, String password, BuildContext context) async {
    String url = App.loginBase;

    var bodyData = {"username": loginId, "password": password};

    print(url);
    print(bodyData);

    Response response = await http.post(url, body: bodyData);
    print("login response ${response.statusCode}");
    if (response.statusCode == 200) {
      print(response.body);
      var userDetail = profileDetailFromJson(response.body);
      if (userDetail.statusCode == 200 && userDetail.success == true) {
        appState.currentUserData = userDetail;
        appState.accessToken = userDetail.data.token;
        appState.id = userDetail.data.id;

        print(userDetail.toJson());

        await sharedPreferences.setString(Preferences.profile, jsonEncode(userDetail.toJson()));
        await sharedPreferences.setString(Preferences.username, loginId);
        await sharedPreferences.setString(Preferences.password, password);
        await sharedPreferences.setString(Preferences.accessToken, userDetail.data.token);
        return 'success';
      } else if(userDetail.statusCode == 403 && userDetail.code == "bp_account_not_activated") {

        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(emailStr: loginId)));

        Map<String, dynamic> reSendOtp = {
          "username": loginId,
        };

        RestApi.reSendOtp(reSendOtp).then((response) {
          print(response);
          Map<String, dynamic> jsonData = {};
          if(jsonData['code'] == 200 && jsonData['status'] == "success") {
          }
        });

        return userDetail.message;

      } else {
        return userDetail.message;
      }
    } else {
      return 'Something went wrong! Please try later';
    }
  }

  static Future<http.Response> postOtpVerifyOtp(Map<String, dynamic> otpMapData) async {

    String url = App.baseUrlSA + App.activeUser;

    // var headerData = {
    //   "Authorization" : "Bearer "+appState.accessToken
    // };

    print("otp" + url);
    // print(headerData);

    try {
      Response response = await http.post(url, body: otpMapData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch(e) {
      print(e);
      return null;
    }

  }

  static Future<http.Response> reSendOtp(Map<String, dynamic> otpMapData) async {

    String url = App.baseUrlSA + App.reSendEmail;

    print("ReSend" + url);

    try {
      Response response = await http.post(url, body: otpMapData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch(e) {
      print(e);
      return null;
    }

  }

  static Future<String> requestVerificationCodeApi(String email) async {
    String url = App.baseUrl2 + App.reset_password;

    var bodyData = {"email": email};

    var headerData = {
      "Authorization" : "Bearer " + App.adminToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = profileDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'success';
    } else {
      print(response.body);
      return userDetail.message;
    }
  }


  static Future<Response> getThreadListApi() async {

    String url = App.baseUrlSA + App.getThreads ;

    var headerData = {
      "Authorization" : "Bearer " + appState.accessToken
    };

    print(url);
    print(headerData);

    try {
      Response response = await http.get(url,headers: headerData);
      print(response.statusCode);
      return response;
    } catch (e) {
      print(e);
      return null;
    }

  /*  if (response.statusCode == 200) {
      List<thread.ThreadList> list = thread.threadListFromJson(response.body);
      return list;
    } else {
      return null;
    }*/

  }

  static Future<Response> getThreadIdWiseApi(String threadId) async {

    String url = App.baseUrlSA + App.getThreads + "/$threadId";

    var headerData = {
      "Authorization" : "Bearer " + appState.accessToken
    };

    print(url);
    print(headerData);

    try {
      Response response = await http.get(url,headers: headerData);
      print(response.statusCode);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
    /*  if (response.statusCode == 200) {
      List<thread.ThreadList> list = thread.threadListFromJson(response.body);
      return list;
    } else {
      return null;
    }*/

  }

  static Future<MessageElement> getThreadMessages(String threadId) async {

    String url = App.baseUrl + App.messages + '/$threadId';

    var headerData = {
      "Authorization" : "Bearer "+appState.accessToken
    };

    print(url);
    print(headerData);

    Response response = await http.get(url,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<MessageElement> list = threadModelFromJson(response.body);
      return list[0];
    } else {
      return null;
    }
  }

  static Future<Response> socialCreateThreadMessage (String senderId, String message) async {

    String url = App.baseUrl + App.messages;
    var bodyData = {"message": message,"recipients": senderId};
    var headerData = {
      "Authorization" : "Bearer "+appState.accessToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {

      print(response.body);
      return response;
      // return await setThreadId(matchId, jsonDecode(response.body)[0]['id']);

    } else {
      return null;
    }
  }

  static Future<String> createThreadMessage(String senderId, String message,String matchId) async {

    String url = App.baseUrl + App.messages;

    var bodyData = {"message": message,"recipients": senderId};

    var headerData = {
      "Authorization" : "Bearer "+appState.accessToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return await setThreadId(matchId, jsonDecode(response.body)[0]['id']);
    } else {
      return '';
    }
  }

  static Future<String> setThreadId(String matchId, int threadId) async {
    String url = App.baseUrlSA + App.match;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    var bodyData = {
      "match_id" : matchId,
      "thread_id" : '$threadId'
    };

    print(url);
    print(bodyData);
    print(headerData);

    try {
      Response response = await http.post(url,headers: headerData, body: bodyData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return "$threadId";
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> sendThreadMessage(String senderId, String message,String threadId) async {
    String url = App.baseUrl + App.messages;

    var bodyData = {"message": message,"recipients": senderId,"id": threadId};

    var headerData = {
      "Authorization" : "Bearer "+appState.accessToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 'success';
    } else {
      print(response.body);
      return null;
    }
  }

  static Future<String> verifyVerificationCodeApi(String email, String code) async {
    String url = App.baseUrl2 + App.validate_code;

    var bodyData = {"email": email, "code": code};

    var headerData = {
      "Authorization" : "Bearer "+App.adminToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = profileDetailFromJson(response.body);
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
      "Authorization" : "Bearer "+App.adminToken
    };

    print(url);
    print(bodyData);
    print(headerData);

    Response response = await http.post(url, body: bodyData,headers: headerData);
    print(response.statusCode);
    var userDetail = profileDetailFromJson(response.body);
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

    try {
      Response response = await http.get(url,headers: headerData);
      print("data recive ${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.body);
        if(response.body.isNotEmpty) {
          return userDetailsModelFromJson(response.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch(e) {
      print("login errro $e");
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
    String url = App.baseUrlSA + App.userList;

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

  static Future<List<MatchModel>> myMatchApi() async {
    String url = App.baseUrlSA + App.match;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}",
    };

    print(url);
    print(headerData);

    try {
      Response response = await http.get(url,headers: headerData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        if(response.body.isEmpty) {
          print("Response id empty");
        } else {
          return matchModelFromJson(response.body);
        }
      } else {
        print(response.body);
        return List();
      }
    } catch (e) {
      print(e);
      return List();
    }
  }

  static Future<String> sendMatch(String matchId) async {
    String url = App.baseUrlSA + App.match;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    var bodyData = {
      "match_id" : matchId,
      "mutual_match" : "true"
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

  static Future<String> matchReject(String matchId) async {
    String url = App.baseUrlSA + App.match_reject;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    var bodyData = {
      "match_id" : matchId,
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

  static Future<String> updateUserDetails(Map bodyData) async {

    String url = App.baseUrlSA + App.user;

    var headerData = {
      // "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYxMTYzOTk2MywibmJmIjoxNjExNjM5OTYzLCJleHAiOjQ3NjUyMzk5NjMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.HM5lJUFLUeh7ojYImLIwY3wj2mnzaZb_y1g_va8PPWk"
      "Authorization" : "Bearer ${appState.accessToken}",
      // "Content-Type" : "application/json"
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

  static Future<Response> updateUserName(Map bodyData) async {

    String url = App.baseUrlV2 + App.users + "${appState.id}";

    var headerData = {
      // "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYxMTYzOTk2MywibmJmIjoxNjExNjM5OTYzLCJleHAiOjQ3NjUyMzk5NjMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.HM5lJUFLUeh7ojYImLIwY3wj2mnzaZb_y1g_va8PPWk"
      "Authorization" : "Bearer ${appState.accessToken}",
      // "Content-Type" : "application/json"
    };

    print(url);
    print(bodyData);
    print(headerData);

    try {
      Response response = await http.post(url, headers: headerData, body: bodyData);
      print(response.statusCode);
      return response;
      /*if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print(response.body);
        return jsonDecode(response.body)['message'];
      }*/
    } catch (e) {
      print(e);
      return null;
      // return 'Something went wrong! Please try later';
    }
  }

  static Future<Response> postChangePasswordApi (Map passwordData) async {

    String url = App.baseUrlSA + App.changesPassword;

    var headerData = {
      // "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYxMTYzOTk2MywibmJmIjoxNjExNjM5OTYzLCJleHAiOjQ3NjUyMzk5NjMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.HM5lJUFLUeh7ojYImLIwY3wj2mnzaZb_y1g_va8PPWk"
      "Authorization" : "Bearer ${appState.accessToken}",
      // "Content-Type" : "application/json"
    };

    print(url);
    print(passwordData);
    print(headerData);

    try {
      Response response = await http.post(url, headers: headerData, body: passwordData);
      print(response.statusCode);
      return response;
    } catch (e) {
      print(e);
      return null;
      // return 'Something went wrong! Please try later';
    }
  }

  static Future<Response> updateUserDetailsSocial(Map bodyData) async {

    String url = App.baseUrlSA + App.user;

    var headerData = {
      // "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYxMTYzOTk2MywibmJmIjoxNjExNjM5OTYzLCJleHAiOjQ3NjUyMzk5NjMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.HM5lJUFLUeh7ojYImLIwY3wj2mnzaZb_y1g_va8PPWk"
      "Authorization" : "Bearer ${appState.accessToken}",
      // "Content-Type" : "application/json"
    };

    print(url);
    print(bodyData);
    print(headerData);

    try {
      Response response = await http.post(url,headers: headerData, body: bodyData);
      print(response.statusCode);
      return response;
      /*if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print(response.body);
        return jsonDecode(response.body)['message'];
      }*/
    } catch (e) {
      print(e);
      return null;
      // return 'Something went wrong! Please try later';
    }
  }

  static Future<String> likeButtonPress(String targetId,int status,int superLike) async {
    String url = App.baseUrlSA + App.i_like_you;

    var headerData = {
      "Authorization" : "Bearer ${appState.accessToken}"
    };

    var bodyData = {
      "target_id" : targetId.toString(),
      "status" : status.toString(),
      "time" : DateTime.now().toString(),
      "superLike" : superLike.toString()
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


  static Future<http.StreamedResponse> updateUserProfile(File image) async {

    String url = App.baseUrl + "members/${appState.currentUserData.data.id}/avatar";
    d.Dio dio = d.Dio();
    var headerData = {
      // "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYxMTYzOTk2MywibmJmIjoxNjExNjM5OTYzLCJleHAiOjQ3NjUyMzk5NjMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.HM5lJUFLUeh7ojYImLIwY3wj2mnzaZb_y1g_va8PPWk"
      "Authorization" : "Bearer ${appState.accessToken}",
      // "Content-Type":"multipart/form-data"
      // "Content-Type" : "application/json"
    };

    print(url);
    print(headerData);
    
    try {

      var uri = Uri.parse(url);

      http.MultipartRequest request = new http.MultipartRequest('POST', uri);

      List<MultipartFile> newList = new List<MultipartFile>();
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      request.fields['action'] = 'bp_avatar_upload';
      var multipartFile = new http.MultipartFile("file", stream, length, filename: image.path);
      newList.add(multipartFile);
      request.files.addAll(newList);
      request.headers.addAll(headerData);
      var response = await request.send();
      return response;


    } catch (e) {
      print(e);
      return null;
      // return 'Something went wrong! Please try later';
    }
  }


}
