// To parse this JSON data, do
//
//     final postCreateModel = postCreateModelFromJson(jsonString);

import 'dart:convert';

PostCreateModel postCreateModelFromJson(String str) =>
    PostCreateModel.fromJson(json.decode(str));

String postCreateModelToJson(PostCreateModel data) =>
    json.encode(data.toJson());

class PostCreateModel {
  String caption;
  String? video;
  String? image;
  String type;

  PostCreateModel({
    required this.caption,
    required this.video,
    required this.image,
    required this.type,
  });

  factory PostCreateModel.fromJson(Map<String, dynamic> json) =>
      PostCreateModel(
        caption: json["caption"],
        video: json["video"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "video": video,
        "image": image,
        "type": type,
      };
}
