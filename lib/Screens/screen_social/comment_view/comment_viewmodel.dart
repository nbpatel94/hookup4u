import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/getPostDataModel.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import 'comment_screen.dart';

class CommentViewModel {

  List<CommentData> commentData = List();

  bool isEmptyMessageShow = false;

  CommentScreenState state;
  CommentViewModel(this.state) {
    showCommentApi(true);
  }

  showCommentApi(bool isLoaderShow) {
    // FocusScope.of(state.context).requestFocus(new FocusNode());

    FocusScope.of(state.context).unfocus();

    if(isLoaderShow) {
      EasyLoading.show();
    }

    // Map<String, dynamic> postComment = {
    //   "post_id": state.widget.postId,
    // };
    // print(postComment);

    SocialRestApi.getCommentList(state.widget.postId).then((value) {
      print(value);
      GetPostDataModel getPostDataModel = GetPostDataModel.fromJson(json.decode(value.body));
      // Map<String, dynamic> message = jsonDecode(value.body);
      if(getPostDataModel.code == 200 && getPostDataModel.status == "success") {
        // Utils().showToast(message['message']);
        state.commentController.clear();
        isEmptyMessageShow = true;
        commentData = List();
        getPostDataModel.data.forEach((element) {
          commentData.add(element);
        });
        state.setState(() {});

      } else if(getPostDataModel.status == "error"){
        Utils().showToast(getPostDataModel.message);
      } else {
        Utils().showToast("something wrong");
      }
    });

  }

  addCommentApi(String postId, String parentPost) {
    FocusScope.of(state.context).requestFocus(new FocusNode());
    EasyLoading.show();
    Map<String, dynamic> postComment = {
      "post_id": postId,
      "comment_content": state.commentController.text,
      "parent_id": parentPost
    };
    state.commentController.clear();
    print(postComment);
    SocialRestApi.commentPostData(postComment).then((value) {
      print(value);
      Map<String, dynamic> message = jsonDecode(value.body);
      if(message['code'] == 200 && message['status'] == "success") {
        Utils().showToast(message['message']);
        showCommentApi(true);
      } else if(message['status'] == "error"){
        Utils().showToast(message['message']);
      } else {
        Utils().showToast("something wrong");
      }
    });
  }

}