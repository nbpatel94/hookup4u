class NotificationDataModel {
  String id;
  String userId;
  String itemId;
  String secondaryItemId;
  String componentName;
  String componentAction;
  String dateNotified;
  String isNew;
  String notificationThumb;
  String senderName;
  List<Post> post;
  List<Comment> comment;


  NotificationDataModel(
      {this.id,
        this.userId,
        this.itemId,
        this.secondaryItemId,
        this.componentName,
        this.componentAction,
        this.dateNotified,
        this.isNew,
        this.notificationThumb,
        this.senderName,
        this.post,
        this.comment
      });

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    secondaryItemId = json['secondary_item_id'];
    componentName = json['component_name'];
    componentAction = json['component_action'];
    dateNotified = json['date_notified'];
    isNew = json['is_new'];
    notificationThumb = json['notification_thumb'];
    senderName = json['sender_name'];
    if (json['post'] != null) {
      post = new List<Post>();
      json['post'].forEach((v) {
        post.add(new Post.fromJson(v));
      });
    }
    if (json['comment'] != null) {
      post = new List<Post>();
      json['comment'].forEach((v) {
        post.add(new Post.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['item_id'] = this.itemId;
    data['secondary_item_id'] = this.secondaryItemId;
    data['component_name'] = this.componentName;
    data['component_action'] = this.componentAction;
    data['date_notified'] = this.dateNotified;
    data['is_new'] = this.isNew;
    data['notification_thumb'] = this.notificationThumb;
    data['sender_name'] = this.senderName;
    if (this.post != null) {
      data['post'] = this.post.map((v) => v.toJson()).toList();
    }
    if (this.comment != null) {
      data['comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Comment {
  Comment({
    this.commentId,
    this.userId,
    this.postId,
    this.commentContent,
    this.parentId,
    this.commentDate,
  });

  String commentId;
  String userId;
  String postId;
  String commentContent;
  dynamic parentId;
  DateTime commentDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    userId: json["user_id"],
    postId: json["post_id"],
    commentContent: json["comment_content"],
    parentId: json["parent_id"],
    commentDate: DateTime.parse(json["comment_date"]),
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "user_id": userId,
    "post_id": postId,
    "comment_content": commentContent,
    "parent_id": parentId,
    "comment_date": commentDate.toIso8601String(),
  };
}


class Post {
  String id;
  String userId;
  String content;
  String media;
  String visibility;
  String parentPost;
  String postDate;

  Post(
      {this.id,
        this.userId,
        this.content,
        this.media,
        this.visibility,
        this.parentPost,
        this.postDate});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    media = json['media'];
    visibility = json['visibility'];
    parentPost = json['parent_post'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['media'] = this.media;
    data['visibility'] = this.visibility;
    data['parent_post'] = this.parentPost;
    data['post_date'] = this.postDate;
    return data;
  }
}



// class NotificationDataModel {
//   int id;
//   int userId;
//   int itemId;
//   int secondaryItemId;
//   String component;
//   String action;
//   String date;
//   int isNew;
//   Links lLinks;
//
//   NotificationDataModel(
//       {this.id,
//         this.userId,
//         this.itemId,
//         this.secondaryItemId,
//         this.component,
//         this.action,
//         this.date,
//         this.isNew,
//         this.lLinks});
//
//   NotificationDataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     itemId = json['item_id'];
//     secondaryItemId = json['secondary_item_id'];
//     component = json['component'];
//     action = json['action'];
//     date = json['date'];
//     isNew = json['is_new'];
//     lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['item_id'] = this.itemId;
//     data['secondary_item_id'] = this.secondaryItemId;
//     data['component'] = this.component;
//     data['action'] = this.action;
//     data['date'] = this.date;
//     data['is_new'] = this.isNew;
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks.toJson();
//     }
//     return data;
//   }
// }
//
// class Links {
//   List<Self> self;
//   List<Self> collection;
//   List<User> user;
//
//   Links({this.self, this.collection, this.user});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     if (json['self'] != null) {
//       self = new List<Self>();
//       json['self'].forEach((v) {
//         self.add(new Self.fromJson(v));
//       });
//     }
//     if (json['collection'] != null) {
//       collection = new List<Self>();
//       json['collection'].forEach((v) {
//         collection.add(Self.fromJson(v));
//       });
//     }
//     if (json['user'] != null) {
//       user = new List<User>();
//       json['user'].forEach((v) {
//         user.add(new User.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self.map((v) => v.toJson()).toList();
//     }
//     if (this.collection != null) {
//       data['collection'] = this.collection.map((v) => v.toJson()).toList();
//     }
//     if (this.user != null) {
//       data['user'] = this.user.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Self {
//   String href;
//
//   Self({this.href});
//
//   Self.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
//
//
//
// class User {
//   bool embeddable;
//   String href;
//
//   User({this.embeddable, this.href});
//
//   User.fromJson(Map<String, dynamic> json) {
//     embeddable = json['embeddable'];
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['embeddable'] = this.embeddable;
//     data['href'] = this.href;
//     return data;
//   }
// }
