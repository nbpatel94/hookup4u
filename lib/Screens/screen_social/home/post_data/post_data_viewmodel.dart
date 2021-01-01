import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/screen_social/home/post_data/post_data_screen.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostDataViewModel {

  List<String> imagesList = List();


  PostDataScreenState state;
  PostDataViewModel(this.state) {

  }

  Future<Void> imageUpload(File image) async {

    EasyLoading.show();

    SocialRestApi.uploadSocialMediaImage(image).then((value) {
      if(value != null) {
        imagesList.add(value.sourceUrl.toString());
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
    });

  }

 /* Future<Void> imageUpload(List<int> imageData, String name) async {

    // EasyLoading.show();

    SocialRestApi.uploadSocialMediaImage(imageData, name).then((value) {
      if(value != null) {
        imagesList.add(value.sourceUrl.toString());
      } else {
        Utils().showToast("Data is empty");
      }
      //flase load;
    });

  }*/

  addPostApi() {
    Map<String, dynamic> postData = {
      "content": state.containController.text,
      "media": imagesList.toString(),
      "visibility": state.dropdownValue,
      "parent_post": ""
    };

    SocialRestApi.uploadPostData(postData).then((value) {
      print(value);
      Navigator.pop(state.context, true);
    });

  }

}


/*  MultipartFile multipartFile = MultipartFile.fromBytes(
      imageData,
      // file name
      filename: 'some-file-name.jpg',
      // file type
      contentType: MediaType("image", "jpg"),
    );
    FormData formData = FormData.fromMap({
      // Parameter name of the back-end interface
      "files": multipartFile
    });*/

/* // backend interface url
    String url = ''；
    // Other parameters of the back-end interface
    Map<String, dynamic> params = Map();
    // Use dio to upload pictures*/

// Dio dio = Dio();
// var response = await dio.post(url, data: formData, queryParameters: params);