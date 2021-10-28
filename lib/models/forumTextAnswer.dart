// To parse this JSON data, do
//
//     final forumTextAnswer = forumTextAnswerFromJson(jsonString);

import 'dart:convert';

ForumTextAnswer forumTextAnswerFromJson(String str) => ForumTextAnswer.fromJson(json.decode(str));

String forumTextAnswerToJson(ForumTextAnswer data) => json.encode(data.toJson());

class ForumTextAnswer {
  ForumTextAnswer({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory ForumTextAnswer.fromJson(Map<String, dynamic> json) => ForumTextAnswer(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.text,
    this.forum,
    this.user,
    this.userDetails,
  });

  int id;
  String text;
  int forum;
  int user;
  UserDetails userDetails;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    text: json["text"],
    forum: json["forum"],
    user: json["user"],
    userDetails: UserDetails.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "forum": forum,
    "user": user,
    "user_details": userDetails.toJson(),
  };
}

class UserDetails {
  UserDetails({
    this.id,
    this.userSegments,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.isStaff,
    this.isActive,
    this.status,
    this.role,
    this.dateJoined,
    this.staffRole,
    this.groups,
    this.userPermissions,
    this.hasWaitingVerificationRequest,
  });

  int id;
  List<dynamic> userSegments;
  String password;
  dynamic lastLogin;
  bool isSuperuser;
  String firstName;
  String lastName;
  dynamic image;
  String email;
  bool isStaff;
  bool isActive;
  int status;
  String role;
  DateTime dateJoined;
  dynamic staffRole;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  bool hasWaitingVerificationRequest;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    userSegments: List<dynamic>.from(json["user_segments"].map((x) => x)),
    password: json["password"],
    lastLogin: json["last_login"],
    isSuperuser: json["is_superuser"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    status: json["status"],
    role: json["role"],
    dateJoined: DateTime.parse(json["date_joined"]),
    staffRole: json["staff_role"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    hasWaitingVerificationRequest: json["has_waiting_verification_request"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
    "password": password,
    "last_login": lastLogin,
    "is_superuser": isSuperuser,
    "first_name": firstName,
    "last_name": lastName,
    "image": image,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "status": status,
    "role": role,
    "date_joined": dateJoined.toIso8601String(),
    "staff_role": staffRole,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    "has_waiting_verification_request": hasWaitingVerificationRequest,
  };
}
