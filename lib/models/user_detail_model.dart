// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

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

  int id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  Map<String, String> avatarUrls;
  Meta meta;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    description: json["description"],
    link: json["link"],
    slug: json["slug"],
    avatarUrls: Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "description": description,
    "link": link,
    "slug": slug,
    "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "meta": meta.toJson(),
  };
}

class Meta {
  Meta({
    this.about,
    this.dateOfBirth,
    this.sexualOrientation,
    this.jobTitle,
    this.relation,
    this.livingIn,
    this.gender,
  });

  String about;
  String dateOfBirth;
  String sexualOrientation;
  String jobTitle;
  String relation;
  String livingIn;
  String gender;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    about: json["about"],
    dateOfBirth: json["date_of_birth"],
    sexualOrientation: json["sexual_orientation"],
    jobTitle: json["job_title"],
    relation: json["relation"],
    livingIn: json["living_in"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id" : appState.userDetail.data.id.toString(),
    "about": about,
    "sexual_orientation": sexualOrientation,
    "job_title": jobTitle,
    "relation": relation,
    "living_in": livingIn,
  };
}
