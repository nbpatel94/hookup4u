// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

import 'package:hookup4u/models/user_detail_model.dart';

List<ActivityModel> activityModelFromJson(String str) => List<ActivityModel>.from(json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    this.id,
    this.name,
    this.link,
    this.meta,
  });

  int id;
  String name;
  String link;
  Meta meta;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "meta": meta.toJson(),
  };
}
