class GetPostDataModel {
  int code;
  String message;
  String status;
  List<CommentData> data;

  GetPostDataModel({this.code, this.message, this.status, this.data});

  GetPostDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CommentData>();
      json['data'].forEach((v) {
        data.add(new CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['postData'] = this.data.map((v) => v.toJson()).toList();
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
  String thumb;
  List<ChildComment> childComment;

  CommentData(
      {this.commentId,
        this.userId,
        this.postId,
        this.commentContent,
        this.parentId,
        this.commentDate,
        this.userName,
        this.thumb,
        this.childComment});

  CommentData.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentContent = json['comment_content'];
    parentId = json['parent_id'];
    commentDate = json['comment_date'];
    userName = json['user_name'];
    thumb = json['thumb'];
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
    data['thumb'] = this.thumb;
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
  String thumb;

  ChildComment(
      {this.commentId,
        this.userId,
        this.postId,
        this.commentContent,
        this.parentId,
        this.thumb,
        this.commentDate});

  ChildComment.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentContent = json['comment_content'];
    parentId = json['parent_id'];
    commentDate = json['comment_date'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment_content'] = this.commentContent;
    data['parent_id'] = this.parentId;
    data['comment_date'] = this.commentDate;
    data['thumb'] = this.thumb;
    return data;
  }
}
