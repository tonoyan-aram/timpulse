import 'dart:convert';

GetRequest requestFromJson(String str) => GetRequest.fromJson(json.decode(str));

String requestToJson(GetRequest data) => json.encode(data.toJson());

class GetRequest {
  GetRequest({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory GetRequest.fromJson(Map<String, dynamic> json) => GetRequest(
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
    this.author,
    this.authorDetails,
    this.title,
    this.text,
    this.file,
    this.staffRole,
    this.staffRoleDetails,
    this.status,
    this.attachedTo,
    this.attachedToUserDetails,
    this.attacheToByUser,
    this.attacheToByUserDetails,
    this.createdAt,
    this.answer,
    this.answeredAt,
  });

  int id;
  int author;
  RDetails authorDetails;
  String title;
  String text;
  String file;
  int staffRole;
  StaffRoleDetails staffRoleDetails;
  String status;
  int attachedTo;
  RDetails attachedToUserDetails;
  dynamic attacheToByUser;
  dynamic attacheToByUserDetails;
  DateTime createdAt;
  String answer;
  DateTime answeredAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    author: json["author"],
    authorDetails: RDetails.fromJson(json["author_details"]),
    title: json["title"],
    text: json["text"],
    file: json["file"] == null ? null : json["file"],
    staffRole: json["staff_role"],
    staffRoleDetails: StaffRoleDetails.fromJson(json["staff_role_details"]),
    status: json["status"],
    attachedTo: json["attached_to"] == null ? null : json["attached_to"],
    attachedToUserDetails: json["attached_to_user_details"] == null ? null : RDetails.fromJson(json["attached_to_user_details"]),
    attacheToByUser: json["attache_to_by_user"],
    attacheToByUserDetails: json["attache_to_by_user_details"],
    createdAt: DateTime.parse(json["created_at"]),
    answer: json["answer"] == null ? null : json["answer"],
    answeredAt: json["answered_at"] == null ? null : DateTime.parse(json["answered_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "author_details": authorDetails.toJson(),
    "title": title,
    "text": text,
    "file": file == null ? null : file,
    "staff_role": staffRole,
    "staff_role_details": staffRoleDetails.toJson(),
    "status": status,
    "attached_to": attachedTo == null ? null : attachedTo,
    "attached_to_user_details": attachedToUserDetails == null ? null : attachedToUserDetails.toJson(),
    "attache_to_by_user": attacheToByUser,
    "attache_to_by_user_details": attacheToByUserDetails,
    "created_at": createdAt.toIso8601String(),
    "answer": answer == null ? null : answer,
    "answered_at": answeredAt == null ? null : answeredAt.toIso8601String(),
  };
}

class RDetails {
  RDetails({
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
  DateTime lastLogin;
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
  int staffRole;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  bool hasWaitingVerificationRequest;

  factory RDetails.fromJson(Map<String, dynamic> json) => RDetails(
    id: json["id"],
    userSegments: List<dynamic>.from(json["user_segments"].map((x) => x)),
    password: json["password"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    isSuperuser: json["is_superuser"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"] == null ? null : json["image"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    status: json["status"],
    role: json["role"],
    dateJoined: DateTime.parse(json["date_joined"]),
    staffRole: json["staff_role"] == null ? null : json["staff_role"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    hasWaitingVerificationRequest: json["has_waiting_verification_request"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
    "password": password,
    "last_login": lastLogin == null ? null : lastLogin.toIso8601String(),
    "is_superuser": isSuperuser,
    "first_name": firstName,
    "last_name": lastName,
    "image": image == null ? null : image,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "status": status,
    "role": role,
    "date_joined": dateJoined.toIso8601String(),
    "staff_role": staffRole == null ? null : staffRole,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    "has_waiting_verification_request": hasWaitingVerificationRequest,
  };
}

class StaffRoleDetails {
  StaffRoleDetails({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory StaffRoleDetails.fromJson(Map<String, dynamic> json) => StaffRoleDetails(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
