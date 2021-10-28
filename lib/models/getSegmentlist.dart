

import 'dart:convert';

SegmentList segmentListFromJson(String str) => SegmentList.fromJson(json.decode(str));

String segmentListToJson(SegmentList data) => json.encode(data.toJson());

class SegmentList {
  SegmentList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory SegmentList.fromJson(Map<String, dynamic> json) => SegmentList(
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
    id: json.containsKey("id") ? json["id"] : "",
    name: json.containsKey("name") ? json["name"] : "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
