class UserDetailsModel {
  String userId;
  String name;
  String about;
  String dateOfBirth;
  String jobTitle;
  String relation;
  String livingIn;
  String gender;
  String children;
  String deviceToken;
  String subscriptionName;
  String subscriptionDate;
  String superlikes;
  String likes;
  String superLikeTime;
  String likeTime;
  String education;
  String fieldOfStudy;
  String lookingFor;

  UserDetailsModel(
      {this.userId,
        this.name,
        this.about,
        this.dateOfBirth,
        this.jobTitle,
        this.relation,
        this.livingIn,
        this.gender,
        this.children,
        this.deviceToken,
        this.subscriptionName,
        this.subscriptionDate,
        this.superlikes,
        this.likes,
        this.superLikeTime,
        this.likeTime,
        this.education,
        this.fieldOfStudy,
        this.lookingFor});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    about = json['about'];
    dateOfBirth = json['date_of_birth'];
    jobTitle = json['job_title'];
    relation = json['relation'];
    livingIn = json['living_in'];
    gender = json['gender'];
    children = json['children'];
    deviceToken = json['device_token'];
    subscriptionName = json['subscription_name'];
    subscriptionDate = json['subscription_date'];
    superlikes = json['superlikes'];
    likes = json['likes'];
    superLikeTime = json['superLikeTime'];
    likeTime = json['likeTime'];
    education = json['education'];
    fieldOfStudy = json['field_of_study'];
    lookingFor = json['looking_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['about'] = this.about;
    data['date_of_birth'] = this.dateOfBirth;
    data['job_title'] = this.jobTitle;
    data['relation'] = this.relation;
    data['living_in'] = this.livingIn;
    data['gender'] = this.gender;
    data['children'] = this.children;
    data['device_token'] = this.deviceToken;
    data['subscription_name'] = this.subscriptionName;
    data['subscription_date'] = this.subscriptionDate;
    data['superlikes'] = this.superlikes;
    data['likes'] = this.likes;
    data['superLikeTime'] = this.superLikeTime;
    data['likeTime'] = this.likeTime;
    data['education'] = this.education;
    data['field_of_study'] = this.fieldOfStudy;
    data['looking_for'] = this.lookingFor;
    return data;
  }
}
