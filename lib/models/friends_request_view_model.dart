class FriendsRequestViewModel {
  int id;
  int initiatorId;
  int friendId;
  bool isConfirmed;
  String dateCreated;
  Links lLinks;

  FriendsRequestViewModel(
      {this.id,
        this.initiatorId,
        this.friendId,
        this.isConfirmed,
        this.dateCreated,
        this.lLinks});

  FriendsRequestViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initiatorId = json['initiator_id'];
    friendId = json['friend_id'];
    isConfirmed = json['is_confirmed'];
    dateCreated = json['date_created'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initiator_id'] = this.initiatorId;
    data['friend_id'] = this.friendId;
    data['is_confirmed'] = this.isConfirmed;
    data['date_created'] = this.dateCreated;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  List<Self> self;
  List<Self> collection;
  List<Initiator> initiator;
  List<Initiator> friend;

  Links({this.self, this.collection, this.initiator, this.friend});

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
    if (json['initiator'] != null) {
      initiator = new List<Initiator>();
      json['initiator'].forEach((v) {
        initiator.add(new Initiator.fromJson(v));
      });
    }
    if (json['friend'] != null) {
      friend = new List<Initiator>();
      json['friend'].forEach((v) {
        friend.add(new Initiator.fromJson(v));
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
    if (this.initiator != null) {
      data['initiator'] = this.initiator.map((v) => v.toJson()).toList();
    }
    if (this.friend != null) {
      data['friend'] = this.friend.map((v) => v.toJson()).toList();
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

class Initiator {
  bool embeddable;
  String href;

  Initiator({this.embeddable, this.href});

  Initiator.fromJson(Map<String, dynamic> json) {
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
