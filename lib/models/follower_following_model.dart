class FollowerFollowingModel {
  int code;
  String message;
  String status;
  Data data;

  FollowerFollowingModel({this.code, this.message, this.status, this.data});

  FollowerFollowingModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Follower> follower;
  List<Following> following;

  Data({this.follower, this.following});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['follower'] != null) {
      follower = new List<Follower>();
      json['follower'].forEach((v) {
        follower.add(new Follower.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = new List<Following>();
      json['following'].forEach((v) {
        following.add(new Following.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.follower != null) {
      data['follower'] = this.follower.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Follower {
  String id;
  String name;
  String thumb;
  bool following;

  Follower({this.id, this.name, this.thumb, this.following});

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumb = json['thumb'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumb'] = this.thumb;
    data['following'] = this.following;
    return data;
  }
}

class Following {
  String id;
  String name;
  String thumb;
  bool following;

  Following({this.id, this.name, this.thumb, this.following});

  Following.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumb = json['thumb'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumb'] = this.thumb;
    data['following'] = this.following;
    return data;
  }
}
