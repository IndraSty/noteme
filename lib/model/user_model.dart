import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    this.uid,
    this.email,
    this.keyName,
    this.name,
    this.img,
    this.phone,
    this.status,
    this.createAt,
    this.lastSignInTime,
    this.updateAt,
  });

  String? uid;
  String? email;
  String? keyName;
  String? name;
  String? img;
  String? phone;
  String? status;
  String? createAt;
  String? lastSignInTime;
  String? updateAt;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        uid: json["uid"],
        email: json["email"],
        keyName: json["keyName"],
        name: json["name"],
        img: json["img"],
        phone: json["phone"],
        status: json["status"],
        createAt: json["create_at"],
        lastSignInTime: json["lastSignInTime"],
        updateAt: json["update_at"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "keyName": keyName,
        "name": name,
        "img": img,
        "phone": phone,
        "status": status,
        "create_at": createAt,
        "lastSignInTime": lastSignInTime,
        "update_at": updateAt,
      };
}
