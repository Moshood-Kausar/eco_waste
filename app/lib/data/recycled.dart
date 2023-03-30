import 'dart:convert';

Recycled recycledFromJson(String str) => Recycled.fromJson(json.decode(str));

String recycledToJson(Recycled data) => json.encode(data.toJson());

class Recycled {
  Recycled({
    required this.userId,
    required this.item,
    required this.qty,
    required this.isPickedUp,
    required this.createdAt,
  });

  String userId;
  String item;
  String qty;
  bool isPickedUp;
  String createdAt;

  factory Recycled.fromJson(Map<String, dynamic> json) => Recycled(
        userId: json["userID"],
        item: json["item"],
        qty: json["qty"],
        isPickedUp: json["isPickedUp"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "item": item,
        "qty": qty,
        "isPickedUp": isPickedUp,
        "created_at": createdAt,
      };
}
