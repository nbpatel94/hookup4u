// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) => List<ActivityModel>.from(json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    this.id,
    this.creatorId,
    this.parentId,
    this.dateCreated,
    this.description,
    this.enableForum,
    this.link,
    this.name,
    this.slug,
    this.status,
    this.types,
    this.avatarUrls,
    this.links,
  });

  int id;
  int creatorId;
  int parentId;
  DateTime dateCreated;
  Description description;
  bool enableForum;
  String link;
  String name;
  String slug;
  String status;
  List<dynamic> types;
  AvatarUrls avatarUrls;
  Links links;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json["id"],
    creatorId: json["creator_id"],
    parentId: json["parent_id"],
    dateCreated: DateTime.parse(json["date_created"]),
    description: Description.fromJson(json["description"]),
    enableForum: json["enable_forum"],
    link: json["link"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    types: List<dynamic>.from(json["types"].map((x) => x)),
    avatarUrls: AvatarUrls.fromJson(json["avatar_urls"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creator_id": creatorId,
    "parent_id": parentId,
    "date_created": dateCreated.toIso8601String(),
    "description": description.toJson(),
    "enable_forum": enableForum,
    "link": link,
    "name": name,
    "slug": slug,
    "status": status,
    "types": List<dynamic>.from(types.map((x) => x)),
    "avatar_urls": avatarUrls.toJson(),
    "_links": links.toJson(),
  };
}

class AvatarUrls {
  AvatarUrls({
    this.full,
    this.thumb,
  });

  String full;
  String thumb;

  factory AvatarUrls.fromJson(Map<String, dynamic> json) => AvatarUrls(
    full: json["full"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "thumb": thumb,
  };
}

class Description {
  Description({
    this.raw,
    this.rendered,
  });

  String raw;
  String rendered;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    raw: json["raw"],
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "rendered": rendered,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.user,
  });

  List<Collection> self;
  List<Collection> collection;
  List<User> user;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class User {
  User({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory User.fromJson(Map<String, dynamic> json) => User(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}
