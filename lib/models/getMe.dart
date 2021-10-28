// To parse this JSON data, do
//
//     final getMe = getMeFromJson(jsonString);

import 'dart:convert';

GetMe getMeFromJson(String str) => GetMe.fromJson(json.decode(str));

String getMeToJson(GetMe data) => json.encode(data.toJson());

class GetMe {
  GetMe({
    this.id,
    this.userSegmentDetails,
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
    this.clientEmployment,
    this.groups,
    this.userPermissions,
    this.clientEmploymentDetails,
    this.hasWaitingVerificationRequest,
    this.userSegments

  });

  int id;
  List<UserSegmentDetails> userSegmentDetails;
  List<int> userSegments;
  String password;
  dynamic lastLogin;
  bool isSuperuser;
  String firstName;
  String lastName;
  String image;
  String email;
  bool isStaff;
  bool isActive;
  int status;
  String role;
  DateTime dateJoined;
  dynamic staffRole;
  int clientEmployment;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  ClientEmploymentDetails clientEmploymentDetails;
  bool hasWaitingVerificationRequest;

  factory GetMe.fromJson(Map<String, dynamic> json) => GetMe(
    id: json["id"],
    userSegmentDetails: List<UserSegmentDetails>.from(json["user_segments_details"].map((x) => UserSegmentDetails.fromJson(x))),
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
    clientEmployment: json["client_employment"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    clientEmploymentDetails: ClientEmploymentDetails.fromJson(json["client_employment_details"]),
    hasWaitingVerificationRequest: json["has_waiting_verification_request"],
    userSegments: List<int>.from(json["user_segments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_segments_details": List<dynamic>.from(userSegmentDetails.map((x) => x.toJson())),
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
    "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
    "client_employment": clientEmployment,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    "client_employment_details": clientEmploymentDetails.toJson(),
    "has_waiting_verification_request": hasWaitingVerificationRequest,
  };
}

class ClientEmploymentDetails {
  ClientEmploymentDetails({
    this.name,
  });

  String name;

  factory ClientEmploymentDetails.fromJson(Map<String, dynamic> json) => ClientEmploymentDetails(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class UserSegmentDetails {
  UserSegmentDetails({
    this.id,
    this.segment,
    this.user,
  });

  int id;
  Segment segment;
  int user;

  factory UserSegmentDetails.fromJson(Map<String, dynamic> json) => UserSegmentDetails(
    id: json["id"],
    segment: Segment.fromJson(json["segment"]),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "segment": segment.toJson(),
    "user": user,
  };
}

class Segment {
  Segment({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
