class GetPostDataModel {
  int code;
  String message;
  String status;
  List<CommentData> commentData;

  GetPostDataModel({this.code, this.message, this.status, this.commentData});

  GetPostDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    if (json['postData'] != null) {
      commentData = new List<CommentData>();
      json['postData'].forEach((v) {
        commentData.add(new CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.commentData != null) {
      data['postData'] = this.commentData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentData {
  String commentId;
  String userId;
  String postId;
  String commentContent;
  String parentId;
  String commentDate;
  String userName;
  List<ChildComment> childComment;

  CommentData(
      {this.commentId,
        this.userId,
        this.postId,
        this.commentContent,
        this.parentId,
        this.commentDate,
        this.userName,
        this.childComment});

  CommentData.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentContent = json['comment_content'];
    parentId = json['parent_id'];
    commentDate = json['comment_date'];
    userName = json['user_name'];
    if (json['child_comment'] != null) {
      childComment = new List<ChildComment>();
      json['child_comment'].forEach((v) {
        childComment.add(new ChildComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment_content'] = this.commentContent;
    data['parent_id'] = this.parentId;
    data['comment_date'] = this.commentDate;
    data['user_name'] = this.userName;
    if (this.childComment != null) {
      data['child_comment'] = this.childComment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildComment {
  String commentId;
  String userId;
  String postId;
  String commentContent;
  String parentId;
  String commentDate;

  ChildComment(
      {this.commentId,
        this.userId,
        this.postId,
        this.commentContent,
        this.parentId,
        this.commentDate});

  ChildComment.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentContent = json['comment_content'];
    parentId = json['parent_id'];
    commentDate = json['comment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment_content'] = this.commentContent;
    data['parent_id'] = this.parentId;
    data['comment_date'] = this.commentDate;
    return data;
  }
}
