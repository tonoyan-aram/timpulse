import 'dart:convert';

Registration registrationFromJson(String str) => Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    this.password,
    this.confirmPassword,
    this.email,
    this.firstName,
    this.lastName,
  });

  String password;
  String confirmPassword;
  String email;
  String firstName;
  String lastName;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    password: json["password"],
    confirmPassword: json["confirm_password"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"]
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "confirm_password": confirmPassword,
    "email": email,
    "first_name":firstName,
    "last_name":lastName
  };
}