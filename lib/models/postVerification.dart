import 'dart:convert';
Verification checkVerificationFromJson(String str) => Verification.fromJson(json.decode(str));

String checkVerificationToJson(Verification data) => json.encode(data.toJson());

class Verification {
  Verification({
    this.user,
    this.file,
  });

  int user;
  String file;

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    user: json["user"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "file": file,
  };
}