import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) => List<ActivityModel>.from(json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    this.data,
    this.media,
    this.about,
    this.dateOfBirth,
    this.jobTitle,
    this.relation,
    this.livingIn,
    this.gender,
    this.children,
  });

  Data data;
  List<String> media;
  String about;
  String dateOfBirth;
  String jobTitle;
  String relation;
  String livingIn;
  String gender;
  String children;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    data: Data.fromJson(json["data"]),
    media: List<String>.from(json["media"].map((x) => x)),
    about: json["about"],
    dateOfBirth: json["date_of_birth"],
    jobTitle: json["job_title"],
    relation: json["relation"],
    livingIn: json["living_in"],
    gender: json["gender"],
    children: json["children"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "media": List<dynamic>.from(media.map((x) => x)),
    "about": about,
    "date_of_birth": dateOfBirth,
    "job_title": jobTitle,
    "relation": relation,
    "living_in": livingIn,
    "gender": gender,
    "children": children,
  };
}

class Data {
  Data({
    this.id,
    this.userLogin,
    this.userPass,
    this.userNicename,
    this.userEmail,
    this.userUrl,
    this.userRegistered,
    this.userActivationKey,
    this.userStatus,
    this.displayName,
  });

  String id;
  String userLogin;
  String userPass;
  String userNicename;
  String userEmail;
  String userUrl;
  DateTime userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    userLogin: json["user_login"],
    userPass: json["user_pass"],
    userNicename: json["user_nicename"],
    userEmail: json["user_email"],
    userUrl: json["user_url"],
    userRegistered: DateTime.parse(json["user_registered"]),
    userActivationKey: json["user_activation_key"],
    userStatus: json["user_status"],
    displayName: json["display_name"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_pass": userPass,
    "user_nicename": userNicename,
    "user_email": userEmail,
    "user_url": userUrl,
    "user_registered": userRegistered.toIso8601String(),
    "user_activation_key": userActivationKey,
    "user_status": userStatus,
    "display_name": displayName,
  };
}
