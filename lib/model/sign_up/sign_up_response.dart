import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) =>
    SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) =>
    json.encode(data.toJson());

class SignUpResponseModel {
  String message;
  String? token;
  SignUpData data;

  SignUpResponseModel({
    required this.message,
    this.token,
    required this.data,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(
        message: json["message"] ?? "", // Default to empty string if message is null
        token: json["token"] ?? "",
        data: SignUpData.fromJson(json["data"] ?? {}), // Default to empty object if data is null
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "data": data.toJson(),
  };
}

class SignUpData {
  String id;
  String email;
  bool isdeleted;
  int v;
  DateTime createdAt;
  String firstname;
  String lastname;
  String roleId;
  DateTime updatedAt;
  String userStatus;
  String language;
  String bio;
  String phoneNumber;
  String profileImage;

  SignUpData({
    required this.id,
    required this.email,
    required this.isdeleted,
    required this.v,
    required this.createdAt,
    required this.firstname,
    required this.lastname,
    required this.roleId,
    required this.updatedAt,
    required this.userStatus,
    required this.language,
    required this.bio,
    required this.phoneNumber,
    required this.profileImage,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
    id: json["_id"] ?? "", // Default to empty string if id is null
    email: json["email"] ?? "", // Default to empty string if email is null
    isdeleted: json["isdeleted"] ?? false, // Default to false if isdeleted is null
    v: json["__v"] ?? 0, // Default to 0 if __v is null
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(), // Default to current time if createdAt is null
    firstname: json["firstname"] ?? "", // Default to empty string if firstname is null
    lastname: json["lastname"] ?? "", // Default to empty string if lastname is null
    roleId: json["roleId"] ?? "", // Default to empty string if roleId is null
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(), // Default to current time if updatedAt is null
    userStatus: json["userStatus"] ?? "", // Default to empty string if userStatus is null
    language: json["language"] ?? "", // Default to empty string if language is null
    bio: json["bio"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    profileImage: json["profileImage"] ?? "", // Default to empty string if phoneNumber is null
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "isdeleted": isdeleted,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "firstname": firstname,
    "lastname": lastname,
    "roleId": roleId,
    "updatedAt": updatedAt.toIso8601String(),
    "userStatus": userStatus,
    "language": language,
    "bio" : bio,
    "phoneNumber": phoneNumber,
    "profileImage": profileImage,
  };
}
