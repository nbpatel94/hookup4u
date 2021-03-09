class ThreadDataModel {
  int code;
  String message;
  String status;
  List<ThreadAllData> data;

  ThreadDataModel({this.code, this.message, this.status, this.data});

  ThreadDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ThreadAllData>();
      json['data'].forEach((v) {
        data.add(new ThreadAllData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThreadAllData {
  String recipient;
  String threadId;
  LastMessage lastMessage;
  RecipientData recipientData;

  ThreadAllData({this.recipient, this.threadId, this.lastMessage, this.recipientData});

  ThreadAllData.fromJson(Map<String, dynamic> json) {
    recipient = json['recipient'];
    threadId = json['thread_id'];
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    recipientData = json['recipient_data'] != null
        ? new RecipientData.fromJson(json['recipient_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient'] = this.recipient;
    data['thread_id'] = this.threadId;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage.toJson();
    }
    if (this.recipientData != null) {
      data['recipient_data'] = this.recipientData.toJson();
    }
    return data;
  }
}

class LastMessage {
  String id;
  String threadId;
  String senderId;
  String subject;
  String message;
  String dateSent;

  LastMessage(
      {this.id,
        this.threadId,
        this.senderId,
        this.subject,
        this.message,
        this.dateSent});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadId = json['thread_id'];
    senderId = json['sender_id'];
    subject = json['subject'];
    message = json['message'];
    dateSent = json['date_sent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thread_id'] = this.threadId;
    data['sender_id'] = this.senderId;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['date_sent'] = this.dateSent;
    return data;
  }
}

class RecipientData {
  String id;
  String thumb;
  String userName;

  RecipientData({this.id, this.thumb, this.userName});

  RecipientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumb = json['thumb'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumb'] = this.thumb;
    data['user_name'] = this.userName;
    return data;
  }
}
