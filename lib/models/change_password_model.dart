class PasswordChangeModel {
  int code;
  String message;
  String status;
  List<String> data;

  PasswordChangeModel({this.code, this.message, this.status, this.data});

  PasswordChangeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
