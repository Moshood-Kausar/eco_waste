import 'dart:convert';

DumpPost dumpPostFromJson(String str) => DumpPost.fromJson(json.decode(str));

String dumpPostToJson(DumpPost data) => json.encode(data.toJson());

class DumpPost {
  DumpPost({
    required this.userId,
    required this.imageUrl,
    required this.landmark,
    required this.location,
    required this.coordinate,
    this.isPicked = false,
    required this.createdAt,
  });

  String userId;
  String imageUrl;
  String landmark;
  String location;
  String coordinate;
  String createdAt;
  bool isPicked;

  factory DumpPost.fromJson(Map<String, dynamic> json) => DumpPost(
        userId: json["userID"],
        imageUrl: json["imageUrl"],
        landmark: json["landmark"],
        location: json["location"],
        coordinate: json["coordinate"],
        isPicked: json["isPicked"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "imageUrl": imageUrl,
        "landmark": landmark,
        "location": location,
        "coordinate": coordinate,
        "isPicked": isPicked,
        "created_at": createdAt,
      };
}
