import 'dart:convert';

CheckEmailRecover checkEmailRecoverFromJson(String str) => CheckEmailRecover.fromJson(json.decode(str));

String checkEmailRecoverToJson(CheckEmailRecover data) => json.encode(data.toJson());

class CheckEmailRecover {
  CheckEmailRecover({
    this.email,
    this.confirmCode,
  });

  String email;
  int confirmCode;

  factory CheckEmailRecover.fromJson(Map<String, dynamic> json) => CheckEmailRecover(
    email: json["email"],
    confirmCode: json["confirm_code"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "confirm_code": confirmCode,
  };
}