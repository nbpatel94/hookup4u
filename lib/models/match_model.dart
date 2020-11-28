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
    this.threadId,
    this.superLike,
    this.mutualMatch,
    this.targetMeta,
    this.senderMeta,
  });

  String matchId;
  String status;
  String name;
  String senderId;
  String taregtId;
  String threadId;
  String lastMessage;
  String mutualMatch;
  int superLike;
  Meta targetMeta;
  Meta senderMeta;

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    matchId: json["match_id"],
    status: json["status"],
    name: json["name"],
    senderId: json["sender_id"],
    taregtId: json["taregt_id"],
    threadId: json["thread_id"],
    superLike: int.parse(json["superlike"]),
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
    "thread_id": threadId,
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
    this.children,
    this.media,
  });

  String name;
  String about;
  String dateOfBirth;
  String jobTitle;
  String relation;
  String livingIn;
  String gender;
  String children;
  List<String> media;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    name: json["name"],
    about: json["about"],
    dateOfBirth: json["date_of_birth"],
    jobTitle: json["job_title"],
    relation: json["relation"],
    livingIn: json["living_in"],
    gender: json["gender"],
    children: json["children"],
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
    "children": children,
    "media": List<dynamic>.from(media.map((x) => x)),
  };
}
