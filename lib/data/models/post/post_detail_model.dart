// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'dart:convert';

PostDetailModel postDetailModelFromJson(String str) =>
    PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) =>
    json.encode(data.toJson());

class PostDetailModel {
  int id;
  User user;
  String caption;
  dynamic video;
  dynamic image;
  String type;
  DateTime createdAt;
  int likeCount;
  int commentCount;

  PostDetailModel({
    required this.id,
    required this.user,
    required this.caption,
    required this.video,
    required this.image,
    required this.type,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
  });

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        id: json["id"],
        user: User.fromJson(json["user"]),
        caption: json["caption"],
        video: json["video"],
        image: json["image"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "caption": caption,
        "video": video,
        "image": image,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "like_count": likeCount,
        "comment_count": commentCount,
      };
}

class User {
  int id;
  String username;
  String profilePic;

  User({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile_pic": profilePic,
      };
}
