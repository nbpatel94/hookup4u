// To parse this JSON data, do
//
//     final socialPostView = socialPostViewFromJson(jsonString);

import 'dart:convert';

SocialPostView socialPostViewFromJson(String str) => SocialPostView.fromJson(json.decode(str));

String socialPostViewToJson(SocialPostView data) => json.encode(data.toJson());

class SocialPostView {
  SocialPostView({
    this.love,
    this.like,
    this.care,
    this.haha,
    this.angry,
    this.sad,
  });

  List<LikeData> love;
  List<LikeData> like;
  List<LikeData> care;
  List<LikeData> haha;
  List<LikeData> angry;
  List<LikeData> sad;

  factory SocialPostView.fromJson(Map<String, dynamic> json) => SocialPostView(
    love: json["#love"] != null   ?  List<LikeData>.from(json["#love"].map((x)  => LikeData.fromJson(x)) ) : null,
    like: json["#like"] != null   ?  List<LikeData>.from(json["#like"].map((x)  => LikeData.fromJson(x)))  : null,
    care: json["#care"] != null   ?  List<LikeData>.from(json["#care"].map((x)  => LikeData.fromJson(x)))  : null,
    haha: json["#haha"] != null   ? List<LikeData>.from( json["#haha"].map((x)  => LikeData.fromJson(x)))  : null,
    angry: json["#angry"] != null ? List<LikeData>.from( json["#angry"].map((x) => LikeData.fromJson(x)))  : null,
    sad: json["#sad"] != null     ? List<LikeData>.from( json["#sad"].map((x)   => LikeData.fromJson(x)))  : null,
  );

  Map<String, dynamic> toJson() => {
    "#love": List<dynamic>.from(love.map((x) => x.toJson())),
    "#like": List<dynamic>.from(like.map((x) => x.toJson())),
    "#care": List<dynamic>.from(care.map((x) => x.toJson())),
    "#haha": List<dynamic>.from(haha.map((x) => x.toJson())),
    "#angry": List<dynamic>.from(angry.map((x) => x.toJson())),
    "#sad": List<dynamic>.from(sad.map((x) => x.toJson())),
  };
}

class LikeData {
  LikeData({
    this.likeId,
    this.postId,
    this.userId,
    this.likeData,
    this.userName,
    this.thumb,
  });

  String likeId;
  String postId;
  String userId;
  String likeData;
  String userName;
  String thumb;

  factory LikeData.fromJson(Map<String, dynamic> json) => LikeData(
    likeId: json["like_id"],
    postId: json["post_id"],
    userId: json["user_id"],
    likeData: json["like_data"],
    userName: json["user_name"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "like_id": likeId,
    "post_id": postId,
    "user_id": userId,
    "like_data": likeData,
    "user_name": userName,
    "thumb": thumb,
  };
}
