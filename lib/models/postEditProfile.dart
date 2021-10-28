import 'dart:convert';

MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));

String myProfileToJson(MyProfile data) => json.encode(data.toJson());

class MyProfile {
  MyProfile({
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.userSegments,
    this.clientEmployment
  });

  String firstName;
  String lastName;
  String image;
  String email;
  List<int> userSegments;
  int clientEmployment;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"],
    email: json["email"],
    userSegments: List<int>.from(json["user_segments"].map((x) => x)),
    clientEmployment: json["client_employment"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "image": image,
    "email": email,
    "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
    "client_employment": clientEmployment,
  };
}

