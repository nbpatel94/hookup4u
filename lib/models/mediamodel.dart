import 'dart:convert';

List<MediaModel> mediaListFromJson(String str) => List<MediaModel>.from(json.decode(str).map((x) => MediaModel.fromJson(x)));
String mediaListToJson(List<MediaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

MediaModel mediaModelFromJson(String str) => MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  MediaModel({
    this.id,
    this.sourceUrl,
  });

  int id;
  String sourceUrl;

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
    id: json["id"],
    sourceUrl: json["source_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source_url": sourceUrl,
  };
}
