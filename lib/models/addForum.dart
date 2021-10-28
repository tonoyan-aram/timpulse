// To parse this JSON data, do
//
//     final addForum = addForumFromJson(jsonString);

import 'dart:convert';

AddForum addForumFromJson(String str) => AddForum.fromJson(json.decode(str));

String addForumToJson(AddForum data) => json.encode(data.toJson());

class AddForum {
  AddForum({
    this.id,
    this.text,
    this.file,
    this.replyType,
    this.createdAt,
    this.endAt,
    this.author,
    this.forumChoices,
    this.segment,
  });

  int id;
  String text;
  dynamic file;
  String replyType;
  DateTime createdAt;
  dynamic endAt;
  String author;
  List<ForumChoice> forumChoices;
  List<Segment> segment;

  factory AddForum.fromJson(Map<String, dynamic> json) => AddForum(
    id: json["id"],
    text: json["text"],
    file: json["file"],
    replyType: json["reply_type"],
    createdAt: DateTime.parse(json["created_at"]),
    endAt: json["end_at"],
    author: json["author"],
    forumChoices: List<ForumChoice>.from(json["forum_choices"].map((x) => ForumChoice.fromJson(x))),
    segment: List<Segment>.from(json["segment"].map((x) => Segment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "file": file,
    "reply_type": replyType,
    "created_at": createdAt.toIso8601String(),
    "end_at": endAt,
    "author": author,
    "forum_choices": List<dynamic>.from(forumChoices.map((x) => x.toJson())),
    "segment": List<dynamic>.from(segment.map((x) => x.toJson())),
  };
}

class ForumChoice {
  ForumChoice({
    this.id,
    this.choice,
    this.forum,
  });

  int id;
  String choice;
  int forum;

  factory ForumChoice.fromJson(Map<String, dynamic> json) => ForumChoice(
    id: json["id"],
    choice: json["choice"],
    forum: json["forum"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "choice": choice,
    "forum": forum,
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
