// To parse this JSON data, do
//
//     final threadModel = threadModelFromJson(jsonString);

import 'dart:convert';

List<MessageElement> threadModelFromJson(String str) => List<MessageElement>.from(json.decode(str).map((x) => MessageElement.fromJson(x)));

String threadModelToJson(List<MessageElement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageElement {
  MessageElement({
    this.date,
    this.unreadCount,
    this.messages,
  });

  DateTime date;
  int unreadCount;
  List<ThreadModel> messages;

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
    date: DateTime.parse(json["date"]),
    unreadCount: json["unread_count"],
    messages: List<ThreadModel>.from(json["messages"].map((x) => ThreadModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "unread_count": unreadCount,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class ThreadModel {
  ThreadModel({
    this.senderId,
    this.message,
    this.dateSent,
  });

  int senderId;
  MessageMessage message;
  DateTime dateSent;

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
    senderId: json["sender_id"],
    message: MessageMessage.fromJson(json["message"]),
    dateSent: DateTime.parse(json["date_sent"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "message": message.toJson(),
    "date_sent": dateSent.toIso8601String(),
  };
}

class MessageMessage {
  MessageMessage({
    this.raw,
  });

  String raw;

  factory MessageMessage.fromJson(Map<String, dynamic> json) => MessageMessage(
    raw: json["raw"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
  };
}
