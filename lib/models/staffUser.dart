// To parse this JSON data, do
//
//     final staffUser = staffUserFromJson(jsonString);

import 'dart:convert';

StaffUser staffUserFromJson(String str) => StaffUser.fromJson(json.decode(str));

String staffUserToJson(StaffUser data) => json.encode(data.toJson());

class StaffUser {
  StaffUser({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory StaffUser.fromJson(Map<String, dynamic> json) => StaffUser(
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
    this.firstName,
    this.lastName,
  });

  int id;
  String firstName;
  String lastName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
