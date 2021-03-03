class FriendsRequestViewModel {
  int code;
  String message;
  String status;
  List<FriendsRequest> data;

  FriendsRequestViewModel({this.code, this.message, this.status, this.data});

  FriendsRequestViewModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<FriendsRequest>();
      json['data'].forEach((v) {
        data.add(new FriendsRequest.fromJson(v));
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

class FriendsRequest {
  String id;
  String initiatorUserId;
  String friendUserId;
  String isConfirmed;
  String isLimited;
  String dateCreated;
  String initiatorName;
  String thumb;

  FriendsRequest(
      {this.id,
        this.initiatorUserId,
        this.friendUserId,
        this.isConfirmed,
        this.isLimited,
        this.dateCreated,
        this.initiatorName,
        this.thumb});

  FriendsRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initiatorUserId = json['initiator_user_id'];
    friendUserId = json['friend_user_id'];
    isConfirmed = json['is_confirmed'];
    isLimited = json['is_limited'];
    dateCreated = json['date_created'];
    initiatorName = json['initiator_name'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initiator_user_id'] = this.initiatorUserId;
    data['friend_user_id'] = this.friendUserId;
    data['is_confirmed'] = this.isConfirmed;
    data['is_limited'] = this.isLimited;
    data['date_created'] = this.dateCreated;
    data['initiator_name'] = this.initiatorName;
    data['thumb'] = this.thumb;
    return data;
  }
}
