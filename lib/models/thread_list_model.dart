// To parse this JSON data, do
//
//     final threadList = threadListFromJson(jsonString);

import 'dart:convert';

List<ThreadList> threadListFromJson(String str) => List<ThreadList>.from(json.decode(str).map((x) => ThreadList.fromJson(x)));

String threadListToJson(List<ThreadList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThreadList {
  ThreadList({
    this.id,
    this.messageId,
    this.lastSenderId,
    this.subject,
    this.excerpt,
    this.message,
    this.date,
    this.unreadCount,
    this.senderIds,
    this.recipients,
    this.messages,
    this.starredMessageIds,
    this.links,
  });

  int id;
  int messageId;
  int lastSenderId;
  Excerpt subject;
  Excerpt excerpt;
  Excerpt message;
  DateTime date;
  int unreadCount;
  Map<String, int> senderIds;
  Map<String, Recipient> recipients;
  List<MessageElement> messages;
  List<dynamic> starredMessageIds;
  Links links;

  factory ThreadList.fromJson(Map<String, dynamic> json) => ThreadList(
    id: json["id"],
    messageId: json["message_id"],
    lastSenderId: json["last_sender_id"],
    subject: Excerpt.fromJson(json["subject"]),
    excerpt: Excerpt.fromJson(json["excerpt"]),
    message: Excerpt.fromJson(json["message"]),
    date: DateTime.parse(json["date"]),
    unreadCount: json["unread_count"],
    senderIds: Map.from(json["sender_ids"]).map((k, v) => MapEntry<String, int>(k, v)),
    recipients: Map.from(json["recipients"]).map((k, v) => MapEntry<String, Recipient>(k, Recipient.fromJson(v))),
    messages: List<MessageElement>.from(json["messages"].map((x) => MessageElement.fromJson(x))),
    starredMessageIds: List<dynamic>.from(json["starred_message_ids"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message_id": messageId,
    "last_sender_id": lastSenderId,
    "subject": subject.toJson(),
    "excerpt": excerpt.toJson(),
    "message": message.toJson(),
    "date": date.toIso8601String(),
    "unread_count": unreadCount,
    "sender_ids": Map.from(senderIds).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "recipients": Map.from(recipients).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "starred_message_ids": List<dynamic>.from(starredMessageIds.map((x) => x)),
    "_links": links.toJson(),
  };
}

class Excerpt {
  Excerpt({
    this.rendered,
  });

  String rendered;

  factory Excerpt.fromJson(Map<String, dynamic> json) => Excerpt(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class Links {
  Links({
    this.the79,
    this.the80,
    this.self,
    this.collection,
    this.the78,
    this.the69,
    this.the70,
  });

  List<Collection> the79;
  List<Collection> the80;
  List<Collection> self;
  List<Collection> collection;
  List<Collection> the78;
  List<Collection> the69;
  List<Collection> the70;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    the79: json["79"] == null ? null : List<Collection>.from(json["79"].map((x) => Collection.fromJson(x))),
    the80: json["80"] == null ? null : List<Collection>.from(json["80"].map((x) => Collection.fromJson(x))),
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    the78: json["78"] == null ? null : List<Collection>.from(json["78"].map((x) => Collection.fromJson(x))),
    the69: json["69"] == null ? null : List<Collection>.from(json["69"].map((x) => Collection.fromJson(x))),
    the70: json["70"] == null ? null : List<Collection>.from(json["70"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "79": the79 == null ? null : List<dynamic>.from(the79.map((x) => x.toJson())),
    "80": the80 == null ? null : List<dynamic>.from(the80.map((x) => x.toJson())),
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "78": the78 == null ? null : List<dynamic>.from(the78.map((x) => x.toJson())),
    "69": the69 == null ? null : List<dynamic>.from(the69.map((x) => x.toJson())),
    "70": the70 == null ? null : List<dynamic>.from(the70.map((x) => x.toJson())),
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

class MessageElement {
  MessageElement({
    this.id,
    this.threadId,
    this.senderId,
    this.subject,
    this.message,
    this.dateSent,
    this.isStarred,
  });

  int id;
  int threadId;
  int senderId;
  SubjectClass subject;
  SubjectClass message;
  DateTime dateSent;
  bool isStarred;

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
    id: json["id"],
    threadId: json["thread_id"],
    senderId: json["sender_id"],
    subject: SubjectClass.fromJson(json["subject"]),
    message: SubjectClass.fromJson(json["message"]),
    dateSent: DateTime.parse(json["date_sent"]),
    isStarred: json["is_starred"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thread_id": threadId,
    "sender_id": senderId,
    "subject": subject.toJson(),
    "message": message.toJson(),
    "date_sent": dateSent.toIso8601String(),
    "is_starred": isStarred,
  };
}

class SubjectClass {
  SubjectClass({
    this.raw,
    this.rendered,
  });

  String raw;
  String rendered;

  factory SubjectClass.fromJson(Map<String, dynamic> json) => SubjectClass(
    raw: json["raw"],
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "rendered": rendered,
  };
}

class Recipient {
  Recipient({
    this.id,
    this.userId,
    this.userLink,
    this.userAvatars,
    this.threadId,
    this.unreadCount,
    this.senderOnly,
    this.isDeleted,
  });

  int id;
  int userId;
  String userLink;
  UserAvatars userAvatars;
  int threadId;
  int unreadCount;
  int senderOnly;
  int isDeleted;

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    id: json["id"],
    userId: json["user_id"],
    userLink: json["user_link"],
    userAvatars: UserAvatars.fromJson(json["user_avatars"]),
    threadId: json["thread_id"],
    unreadCount: json["unread_count"],
    senderOnly: json["sender_only"],
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user_link": userLink,
    "user_avatars": userAvatars.toJson(),
    "thread_id": threadId,
    "unread_count": unreadCount,
    "sender_only": senderOnly,
    "is_deleted": isDeleted,
  };
}

class UserAvatars {
  UserAvatars({
    this.full,
    this.thumb,
  });

  String full;
  String thumb;

  factory UserAvatars.fromJson(Map<String, dynamic> json) => UserAvatars(
    full: json["full"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "thumb": thumb,
  };
}
