// To parse this JSON data, do
//
//     final buddyFollowModel = buddyFollowModelFromJson(jsonString);

import 'dart:convert';

List<BuddyFollowModel> buddyFollowModelFromJson(String str) => List<BuddyFollowModel>.from(json.decode(str).map((x) => BuddyFollowModel.fromJson(x)));

String buddyFollowModelToJson(List<BuddyFollowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BuddyFollowModel {
  int id;
  int follower;
  int following;

  BuddyFollowModel({
    required this.id,
    required this.follower,
    required this.following,
  });

  factory BuddyFollowModel.fromJson(Map<String, dynamic> json) => BuddyFollowModel(
    id: json["id"],
    follower: json["follower"],
    following: json["following"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "follower": follower,
    "following": following,
  };
}
