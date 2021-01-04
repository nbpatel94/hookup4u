import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:http/http.dart' as http;
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:http/http.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SocialRestApi {

  static Future<MediaModel> uploadSocialMediaImage(File file) async {
  // static Future<MediaModel> uploadSocialMediaImage(List<int> imageData, String imageName) async {
    String url = App.baseUrlV2 + App.media;

    // print(imageName);

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
      "Content-Disposition": "attachment; filename=user_image.jpg",
      "Content-Type": "image/png"
    };

    print(url);
    // print(file.absolute.path);
    // print(file.readAsBytesSync());
    // print(imageData);
    print(headerData);

    try {
      // Response response = await http.post(url, headers: headerData, body: imageData);
      Response response = await http.post(url,headers: headerData, body: file.readAsBytesSync());
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response.body);
        return mediaModelFromJson(response.body);
      } else if(response.statusCode == 500) {
        Utils().showToast("Inernal server error");
      } else {
        print(response.body);
        Utils().showToast("Some Thing wrong");
        return null;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }



  static Future<MediaModel> uploadPostData(Map<String, dynamic> postData) async {

    String url = App.baseUrlSA + App.wallPost;

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
      "Content-Type":"application/json"
    };

    print(url + headerData.toString() + postData.toString());

    try {
      Response response = await http.post(url, headers: headerData, body: jsonEncode(postData));
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response.body);
        return mediaModelFromJson(response.body);
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return null;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }


  static Future<Response> editPostData(Map<String, dynamic> postData, String postId) async {

    String url = App.baseUrlSA + App.wallPost + "/$postId";

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
      "Content-Type":"application/json"
    };
    print(url + headerData.toString() + postData.toString());
    try {
      Response response = await http.post(url, headers: headerData, body: jsonEncode(postData));
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response.body);
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return response;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }

  static Future<Response> showPostData() async {

    String url = App.baseUrlSA + App.wallPost;

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
    };
    print(url + headerData.toString());
    try {
      Response response = await http.get(url, headers: headerData);
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response);
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return null;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }



  static Future<Response> deletePostData(String userId) async {

    String url = App.baseUrlSA + App.wallPost + "/$userId";

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
    };

    print(url + headerData.toString());

    try {
      Response response = await http.delete(url, headers: headerData);
      print(response.statusCode);
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        EasyLoading.dismiss();
        print(response.body);
        // SocialPostShowModel socialPostShowModel = SocialPostShowModel.fromJson(jsonDecode(response.body));
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return response;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return null;
    }
  }


  static Future<Response> showMyPostData() async {

    String url = App.baseUrlSA + App.myWallPost;
    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
    };
    print(url + headerData.toString());
    try {
      Response response = await http.get(url, headers: headerData);
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response);
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return response;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }


  //comment post
  static Future<Response> commentPostData(Map<String, dynamic> postData) async {

    String url = App.baseUrlSA + App.wallComment;

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
      "Content-Type":"application/json"
    };

    print(url + headerData.toString() + postData.toString());
    try {
      Response response = await http.post(url, headers: headerData, body: jsonEncode(postData));
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response.body);
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return response;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }

  //get comment list

  static Future<Response> getCommentList(String id) async {

    String url = App.baseUrlSA + App.wallComment + "?post_id=" + id;

    var headerData = {
      "Authorization": "Bearer ${appState.accessToken}",
      "Content-Type":"application/json"
    };

    print(url + headerData.toString() + id.toString());
    try {
      Response response = await http.get(url, headers: headerData);
      print(response.statusCode);
      EasyLoading.dismiss();
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        print(response.body);
        return response;
      } else {
        print(response.body);
        var jsonData = jsonDecode(response.body);
        Utils().showToast(jsonData['message']);
        return response;
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Utils().showToast(e);
      return null;
    }
  }
}
