import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import 'edit_screen.dart';

class EditDataViewModel {

  List<String> imagesList = List();


  EditDataScreenState state;
  EditDataViewModel(this.state) {
    // imagesList.add("https://door.iheartmuslims.com/wp-content/uploads/2021/01/user_image-14-scaled.jpg");
  }

 imageUpload(File image) async {

    EasyLoading.show();
    FocusScope.of(state.context).requestFocus(new FocusNode());
    SocialRestApi.uploadSocialMediaImage(image).then((value) {
      if(value != null) {
        imagesList.add(value.sourceUrl.toString());
        state.setState(() {});
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

  editPostApi(String postId) {

    EasyLoading.show();
    String imageJoint = imagesList.join(",");
    print(imageJoint);

    Map<String, dynamic> postData = {};
    if(state.widget.isShare){
      postData = {
        "content": state.containController.text,
        "media": imageJoint.toString(),
        "visibility": state.dropdownValue,
        "parent_post": state.widget.socialPostShowData.parentPost.id
      };
    } else {
       postData = {
        "content": state.containController.text,
        "media": imageJoint.toString(),
        "visibility": state.dropdownValue,
        "parent_post": ""
      };
    }


    print(postData);

    SocialRestApi.editPostData(postData, postId).then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        Utils().showToast(message['message']);
        Navigator.pop(state.context, true);
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }

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