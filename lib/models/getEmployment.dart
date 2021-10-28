import 'dart:convert';

EmploymentList employmentListFromJson(String str) => EmploymentList.fromJson(json.decode(str));

String employmentListToJson(EmploymentList data) => json.encode(data.toJson());

class EmploymentList {
  EmploymentList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory EmploymentList.fromJson(Map<String, dynamic> json) => EmploymentList(
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
    this.name,
  });

  int id;
  String name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}