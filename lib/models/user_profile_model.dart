class UserProfileModel {
  int code;
  String message;
  String status;
  Data data;

  UserProfileModel({this.code, this.message, this.status, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  UserDetail userDetail;
  int posts;
  int following;
  int follower;
  List<UserPosts> userPosts;
  String thumb;

  Data({this.userDetail, this.posts, this.following, this.follower, this.userPosts, this.thumb});

  Data.fromJson(Map<String, dynamic> json) {
    userDetail = json['user_detail'] != null ? new UserDetail.fromJson(json['user_detail']) : null;
    posts = json['posts'];
    following = json['following'];
    follower = json['follower'];
    if (json['user_posts'] != null) {
      userPosts = new List<UserPosts>();
      json['user_posts'].forEach((v) { userPosts.add(new UserPosts.fromJson(v)); });
    }
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail.toJson();
    }
    data['posts'] = this.posts;
    data['following'] = this.following;
    data['follower'] = this.follower;
    if (this.userPosts != null) {
      data['user_posts'] = this.userPosts.map((v) => v.toJson()).toList();
    }
    data['thumb'] = this.thumb;
    return data;
  }
}

class UserDetail {
  String iD;
  String userLogin;
  String userPass;
  String userNicename;
  String userEmail;
  String userUrl;
  String userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;

  UserDetail({this.iD, this.userLogin, this.userPass, this.userNicename, this.userEmail, this.userUrl, this.userRegistered, this.userActivationKey, this.userStatus, this.displayName});

  UserDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userLogin = json['user_login'];
    userPass = json['user_pass'];
    userNicename = json['user_nicename'];
    userEmail = json['user_email'];
    userUrl = json['user_url'];
    userRegistered = json['user_registered'];
    userActivationKey = json['user_activation_key'];
    userStatus = json['user_status'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_login'] = this.userLogin;
    data['user_pass'] = this.userPass;
    data['user_nicename'] = this.userNicename;
    data['user_email'] = this.userEmail;
    data['user_url'] = this.userUrl;
    data['user_registered'] = this.userRegistered;
    data['user_activation_key'] = this.userActivationKey;
    data['user_status'] = this.userStatus;
    data['display_name'] = this.displayName;
    return data;
  }
}

class UserPosts {
  String id;
  String userId;
  String content;
  List<String> media;
  String visibility;
  ParentPost parentPostData;
  String postDate;
  int commentCount;
  int likeCount;
  bool selfLike;
  String userName;
  String thumb;

  UserPosts({this.id, this.userId, this.content, this.media, this.visibility, this.parentPostData, this.postDate, this.commentCount, this.likeCount, this.selfLike, this.userName, this.thumb});

  UserPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    media = json['media'].cast<String>();
    visibility = json['visibility'];
    parentPostData = json['parent_post'] != null ? new ParentPost.fromJson(json['parent_post']) : null;
    postDate = json['post_date'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    selfLike = json['self_like'];
    userName = json['user_name'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['media'] = this.media;
    data['visibility'] = this.visibility;
    if (this.parentPostData != null) {
      data['parent_post'] = this.parentPostData.toJson();
    }
    data['post_date'] = this.postDate;
    data['comment_count'] = this.commentCount;
    data['like_count'] = this.likeCount;
    data['self_like'] = this.selfLike;
    data['user_name'] = this.userName;
    data['thumb'] = this.thumb;
    return data;
  }
}

class ParentPost {
  String id;
  String userId;
  String content;
  List<String> media;
  String visibility;
  ParentPost parentPost;
  String userName;
  String thumb;
  String postDate;

  ParentPost(
      {this.id,
        this.userId,
        this.content,
        this.media,
        this.visibility,
        this.parentPost,
        this.userName,
        this.thumb,
        this.postDate
      });

  ParentPost.fromJson(Map<String, dynamic> json) {
    print(json['media']);
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    media = json['media'] != null ? json['media'].cast<String>() : null;
    visibility = json['visibility'];
    // parentPost = json['parent_post'];
    parentPost = json['parent_post'] != null && json['parent_post'].length != 0 && json['parent_post'] is Map
        ? new ParentPost.fromJson(json['parent_post'])
        : null;
    userName = json['user_name'];
    thumb = json['thumb'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['media'] = this.media;
    data['visibility'] = this.visibility;
    // data['parent_post'] = this.parentPost;
    if (this.parentPost != null) {
      data['parent_post'] = this.parentPost.toJson();
    }
    data['user_name'] = this.userName;
    data['thumb'] = this.thumb;
    data['post_date'] = this.postDate;
    return data;
  }
}