// import 'dart:convert';
//
// Registrationfinal registrationfinalFromJson(String str) =>
//     Registrationfinal.fromJson(json.decode(str));
//
// String registrationfinalToJson(Registrationfinal data) =>
//     json.encode(data.toJson());
//
// class Registrationfinal {
//   Registrationfinal({
//     this.password,
//     this.confirmPassword,
//     this.email,
//     this.confirmCode,
//     this.firstName,
//     this.lastName,
//   });
//
//   String password;
//   String confirmPassword;
//   String email;
//   String confirmCode;
//   String firstName;
//   String lastName;
//   factory Registrationfinal.fromJson(Map<String, dynamic> json) =>
//       Registrationfinal(
//         password: json["password"],
//         confirmPassword: json["confirm_password"],
//         email: json["email"],
//         confirmCode: json["confirm_code"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "password": password,
//         "confirm_password": confirmPassword,
//         "email": email,
//         "confirm_code": confirmCode,
//         "first_name": firstName,
//         "last_name": lastName,
//       };
// }
//
// class LoginverificationResponse {
//   String refresh;
//   String access;
//   Registrationfinal user;
//
//   LoginverificationResponse({this.refresh, this.access, this.user});
//
//
//   factory LoginverificationResponse.fromJson(Map<String, dynamic> json) =>
//       LoginverificationResponse(
//         refresh: json["refresh"],
//         access: json["access"],
//         user: Registrationfinal.fromJson(json["user"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "refresh": refresh,
//         "access": access,
//         "user": user.toJson(),
//       };
//
// }
//
// //To parse this JSON data, do
//
//    // final registrationfinal = registrationfinalFromJson(jsonString);
//
// // import 'dart:convert';
// //
// // Registrationfinal registrationfinalFromJson(String str) => Registrationfinal.fromJson(json.decode(str));
// //
// // String registrationfinalToJson(Registrationfinal data) => json.encode(data.toJson());
// //
// // class Registrationfinal {
// //   Registrationfinal({
// //     this.refresh,
// //     this.access,
// //     this.user,
// //   });
// //
// //   String refresh;
// //   String access;
// //   User user;
// //
// //   factory Registrationfinal.fromJson(Map<String, dynamic> json) => Registrationfinal(
// //     refresh: json["refresh"],
// //     access: json["access"],
// //     user: User.fromJson(json["user"]),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "refresh": refresh,
// //     "access": access,
// //     "user": user.toJson(),
// //   };
// // }
// //
// // class User {
// //   User({
// //     this.id,
// //     this.userSegments,
// //     this.password,
// //     this.lastLogin,
// //     this.isSuperuser,
// //     this.firstName,
// //     this.lastName,
// //     this.image,
// //     this.email,
// //     this.isStaff,
// //     this.isActive,
// //     this.status,
// //     this.role,
// //     this.dateJoined,
// //     this.staffRole,
// //     this.groups,
// //     this.userPermissions,
// //     this.hasWaitingVerificationRequest,
// //   });
// //
// //   int id;
// //   List<dynamic> userSegments;
// //   String password;
// //   dynamic lastLogin;
// //   bool isSuperuser;
// //   String firstName;
// //   String lastName;
// //   dynamic image;
// //   String email;
// //   bool isStaff;
// //   bool isActive;
// //   int status;
// //   String role;
// //   DateTime dateJoined;
// //   dynamic staffRole;
// //   List<dynamic> groups;
// //   List<dynamic> userPermissions;
// //   bool hasWaitingVerificationRequest;
// //
// //   factory User.fromJson(Map<String, dynamic> json) => User(
// //     id: json["id"],
// //     userSegments: List<dynamic>.from(json["user_segments"].map((x) => x)),
// //     password: json["password"],
// //     lastLogin: json["last_login"],
// //     isSuperuser: json["is_superuser"],
// //     firstName: json["first_name"],
// //     lastName: json["last_name"],
// //     image: json["image"],
// //     email: json["email"],
// //     isStaff: json["is_staff"],
// //     isActive: json["is_active"],
// //     status: json["status"],
// //     role: json["role"],
// //     dateJoined: DateTime.parse(json["date_joined"]),
// //     staffRole: json["staff_role"],
// //     groups: List<dynamic>.from(json["groups"].map((x) => x)),
// //     userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
// //     hasWaitingVerificationRequest: json["has_waiting_verification_request"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
// //     "password": password,
// //     "last_login": lastLogin,
// //     "is_superuser": isSuperuser,
// //     "first_name": firstName,
// //     "last_name": lastName,
// //     "image": image,
// //     "email": email,
// //     "is_staff": isStaff,
// //     "is_active": isActive,
// //     "status": status,
// //     "role": role,
// //     "date_joined": dateJoined.toIso8601String(),
// //     "staff_role": staffRole,
// //     "groups": List<dynamic>.from(groups.map((x) => x)),
// //     "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
// //     "has_waiting_verification_request": hasWaitingVerificationRequest,
// //   };
// // }


import 'dart:convert';

Registrationfinal registrationfinalFromJson(String str) =>
    Registrationfinal.fromJson(json.decode(str));

String registrationfinalToJson(Registrationfinal data) =>
    json.encode(data.toJson());

class Registrationfinal {
  Registrationfinal({
    this.password,
    this.confirmPassword,
    this.email,
    this.confirmCode,
    this.firstName,
    this.lastName,
  });

  String password;
  String confirmPassword;
  String email;
  String confirmCode;
  String firstName;
  String lastName;
  factory Registrationfinal.fromJson(Map<String, dynamic> json) =>
      Registrationfinal(
        password: json["password"],
        confirmPassword: json["confirm_password"],
        email: json["email"],
        confirmCode: json["confirm_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
    "password": password,
    "confirm_password": confirmPassword,
    "email": email,
    "confirm_code": confirmCode,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class User {
  User({
    this.id,
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
    this.userSegments,
    this.userSegmentsDetails,
    this.hasWaitingVerificationRequest,
  });

  int id;
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
  int clientEmployment;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  ClientEmploymentDetails clientEmploymentDetails;
  List<int> userSegments;
  List<UserSegmentsDetail> userSegmentsDetails;
  bool hasWaitingVerificationRequest;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
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
    userSegments: List<int>.from(json["user_segments"].map((x) => x)),
    userSegmentsDetails: List<UserSegmentsDetail>.from(json["user_segments_details"].map((x) => UserSegmentsDetail.fromJson(x))),
    hasWaitingVerificationRequest: json["has_waiting_verification_request"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "client_employment": clientEmployment,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    "client_employment_details": clientEmploymentDetails.toJson(),
    "user_segments": List<dynamic>.from(userSegments.map((x) => x)),
    "user_segments_details": List<dynamic>.from(userSegmentsDetails.map((x) => x.toJson())),
    "has_waiting_verification_request": hasWaitingVerificationRequest,
  };
}

class ClientEmploymentDetails {
  ClientEmploymentDetails({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ClientEmploymentDetails.fromJson(Map<String, dynamic> json) => ClientEmploymentDetails(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class UserSegmentsDetail {
  UserSegmentsDetail({
    this.id,
    this.segment,
    this.user,
  });

  int id;
  ClientEmploymentDetails segment;
  int user;

  factory UserSegmentsDetail.fromJson(Map<String, dynamic> json) => UserSegmentsDetail(
    id: json["id"],
    segment: ClientEmploymentDetails.fromJson(json["segment"]),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "segment": segment.toJson(),
    "user": user,
  };
}



class LoginverificationResponse {
  String refresh;
  String access;
  User user;

  LoginverificationResponse({this.refresh, this.access, this.user});


  factory LoginverificationResponse.fromJson(Map<String, dynamic> json) =>
      LoginverificationResponse(
        refresh: json["refresh"],
        access: json["access"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "refresh": refresh,
    "access": access,
    "user": user.toJson(),
  };

}
