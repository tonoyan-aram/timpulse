// To parse this JSON data, do
//
//     final forumDetails = forumDetailsFromJson(jsonString);

import 'dart:convert';

ForumDetails forumDetailsFromJson(String str) => ForumDetails.fromJson(json.decode(str));

String forumDetailsToJson(ForumDetails data) => json.encode(data.toJson());

class ForumDetails {
  ForumDetails({
    this.id,
    this.text,
    this.file,
    this.replyType,
    this.createdAt,
    this.endAt,
    this.author,
    this.forumChoices,
    this.segment,
    this.answeredByMe,
  });

  int id;
  String text;
  dynamic file;
  String replyType;
  DateTime createdAt;
  DateTime endAt;
  String author;
  List<ForumChoice> forumChoices;
  List<Segment> segment;
  bool answeredByMe;

  factory ForumDetails.fromJson(Map<String, dynamic> json) => ForumDetails(
    id: json["id"],
    text: json["text"],
    file: json["file"],
    replyType: json["reply_type"],
    createdAt: DateTime.parse(json["created_at"]),
    endAt: DateTime.parse(json["end_at"]),
    author: json["author"],
    forumChoices: List<ForumChoice>.from(json["forum_choices"].map((x) => ForumChoice.fromJson(x))),
    segment: List<Segment>.from(json["segment"].map((x) => Segment.fromJson(x))),
    answeredByMe: json["answered_by_me"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "file": file,
    "reply_type": replyType,
    "created_at": createdAt.toIso8601String(),
    "end_at": endAt.toIso8601String(),
    "author": author,
    "forum_choices": List<dynamic>.from(forumChoices.map((x) => x.toJson())),
    "segment": List<dynamic>.from(segment.map((x) => x.toJson())),
    "answered_by_me": answeredByMe,
  };
}

class ForumChoice {
  ForumChoice({
    this.id,
    this.forum,
    this.choice,
    this.answerSum,
  });

  int id;
  int forum;
  String choice;
  int answerSum;

  factory ForumChoice.fromJson(Map<String, dynamic> json) => ForumChoice(
    id: json["id"],
    forum: json["forum"],
    choice: json["choice"],
    answerSum: json["answer_sum"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "forum": forum,
    "choice": choice,
    "answer_sum": answerSum,
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
