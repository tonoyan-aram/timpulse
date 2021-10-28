import 'dart:convert';

EmailRecover emailRecoverFromJson(String str) => EmailRecover.fromJson(json.decode(str));

String emailRecoverToJson(EmailRecover data) => json.encode(data.toJson());

class EmailRecover {
  EmailRecover({
    this.email,
  });

  String email;

  factory EmailRecover.fromJson(Map<String, dynamic> json) => EmailRecover(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}