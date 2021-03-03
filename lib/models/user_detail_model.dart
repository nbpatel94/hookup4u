import 'dart:convert';

import 'package:hookup4u/app.dart';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
    this.meta,
  });

  String id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  Map<String, String> avatarUrls;
  Meta meta;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    id: json["id"].toString(),
    name: json["name"],
    url: json["url"],
    description: json["description"],
    link: json["link"],
    slug: json["slug"],
    avatarUrls: json["avatar_urls"] != null ? Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)) : null,
    meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "description": description,
    "link": link,
    "slug": slug,
    "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "meta": meta.toFirstJson(),
  };
}

class Meta {
  Meta({
    this.name,
    this.about,
    this.dateOfBirth,
    this.jobTitle,
    this.relation,
    this.livingIn,
    this.superLike,
    this.likeCount,
    this.gender,
    this.deviceToken,
    this.superLikeTime,
    this.likeTime,
    this.children,
    this.subscriptionDate,
    this.subscriptionName,
  });

  String name = "";
  String about = "";
  String dateOfBirth = "";
  String jobTitle = "";
  String relation = "";
  String livingIn = "";
  int superLike = null;
  int likeCount = null;
  String gender = "";
  String children = "-";
  String deviceToken = "";
  String superLikeTime = "";
  String likeTime = "";
  String subscriptionName = "";
  DateTime subscriptionDate = null;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    name: json["name"],
    about: json["about"],
    dateOfBirth: json["date_of_birth"],
    jobTitle: json["job_title"],
    relation: json["relation"],
    livingIn: json["living_in"],
    gender: json["gender"],
    superLike: int.parse(json["superlikes"].toString()),
    likeCount: int.parse(json["likes"].toString()),
    deviceToken: json["device_token"],
    children: json["children"],
    superLikeTime: json["superLikeTime"],
    likeTime: json["likeTime"],
    subscriptionName: json["subscription_name"] != null ? json["subscription_name"] : null,
    subscriptionDate: json["subscription_date"] !="" ? DateTime.parse(json["subscription_date"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id" : appState.currentUserData.data.id.toString(),
    "about": about,
    "job_title": jobTitle,
    "relation": relation,
    "living_in": livingIn,
    "children": children ?? '-',
    "subscription_name": subscriptionName ?? "",
    "subscription_date": subscriptionDate != null ?subscriptionDate.toString() : "",
  };

  Map<String, dynamic> toFirstJson() => {
    "name": name,
    "id" : appState.currentUserData.data.id.toString(),
    "about": about,
    "date_of_birth": dateOfBirth.replaceAll('/', '-'),
    "job_title": jobTitle,
    "gender": gender,
    "relation": relation,
    "superlikes": superLike.toString(),
    "likes": likeCount.toString(),
    "living_in": livingIn,
    'device_token' : sharedPreferences.getString("token"),
    "children": children ?? '-',
    "subscription_name": subscriptionName ?? "",
    "subscription_date": subscriptionDate != null ? subscriptionDate.toString() : "",
  };

  Map<String, dynamic> toRemoveToken() => {
    "id" : appState.currentUserData.data.id.toString(),
    "about": about,
    "date_of_birth": dateOfBirth.replaceAll('/', '-'),
    "job_title": jobTitle,
    "gender": gender,
    "relation": relation,
    "superlikes": superLike.toString(),
    "likes": likeCount.toString(),
    "living_in": livingIn,
    'device_token' : deviceToken,
    "children": children ?? '-',
    "subscription_name": subscriptionName ?? "",
    "subscription_date": subscriptionDate != null ? subscriptionDate.toString() : "",
  };

}
