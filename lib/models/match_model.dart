// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';

List<MatchModel> matchModelFromJson(String str) => List<MatchModel>.from(json.decode(str).map((x) => MatchModel.fromJson(x)));

String matchModelToJson(List<MatchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchModel {
  MatchModel({
    this.matchId,
    this.status,
    this.name,
    this.senderId,
    this.taregtId,
    this.mutualMatch,
    this.targetMeta,
    this.senderMeta,
  });

  String matchId;
  String status;
  String name;
  String senderId;
  String taregtId;
  String mutualMatch;
  Meta targetMeta;
  Meta senderMeta;

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    matchId: json["match_id"],
    status: json["status"],
    name: json["name"],
    senderId: json["sender_id"],
    taregtId: json["taregt_id"],
    mutualMatch: json["mutual_match"],
    targetMeta: Meta.fromJson(json["target_meta"]),
    senderMeta: Meta.fromJson(json["sender_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "match_id": matchId,
    "status": status,
    "name": name,
    "sender_id": senderId,
    "taregt_id": taregtId,
    "mutual_match": mutualMatch,
    "target_meta": targetMeta.toJson(),
    "sender_meta": senderMeta.toJson(),
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
    this.gender,
    this.media,
  });

  String name;
  String about;
  String dateOfBirth;
  String jobTitle;
  String relation;
  String livingIn;
  String gender;
  List<String> media;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    name: json["name"],
    about: json["about"],
    dateOfBirth: json["date_of_birth"],
    jobTitle: json["job_title"],
    relation: json["relation"],
    livingIn: json["living_in"],
    gender: json["gender"],
    media: List<String>.from(json["media"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "about": about,
    "date_of_birth": dateOfBirth,
    "job_title": jobTitle,
    "relation": relation,
    "living_in": livingIn,
    "gender": gender,
    "media": List<dynamic>.from(media.map((x) => x)),
  };
}