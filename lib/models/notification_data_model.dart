class NotificationDataModel {
  int id;
  int userId;
  int itemId;
  int secondaryItemId;
  String component;
  String action;
  String date;
  int isNew;
  Links lLinks;

  NotificationDataModel(
      {this.id,
        this.userId,
        this.itemId,
        this.secondaryItemId,
        this.component,
        this.action,
        this.date,
        this.isNew,
        this.lLinks});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    secondaryItemId = json['secondary_item_id'];
    component = json['component'];
    action = json['action'];
    date = json['date'];
    isNew = json['is_new'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['item_id'] = this.itemId;
    data['secondary_item_id'] = this.secondaryItemId;
    data['component'] = this.component;
    data['action'] = this.action;
    data['date'] = this.date;
    data['is_new'] = this.isNew;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  List<Self> self;
  List<Self> collection;
  List<User> user;

  Links({this.self, this.collection, this.user});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = new List<Self>();
      json['self'].forEach((v) {
        self.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = new List<Self>();
      json['collection'].forEach((v) {
        collection.add(Self.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = new List<User>();
      json['user'].forEach((v) {
        user.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}



class User {
  bool embeddable;
  String href;

  User({this.embeddable, this.href});

  User.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}
