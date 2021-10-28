
import 'dart:convert';

ForumTextAnswer forumTextAnswerFromJson(String str) => ForumTextAnswer.fromJson(json.decode(str));

String forumTextAnswerToJson(ForumTextAnswer data) => json.encode(data.toJson());

class ForumTextAnswer {
  ForumTextAnswer({
    this.forum,
    this.text,
    this.user,
  });

  int forum;
  String text;
  int user;

  factory ForumTextAnswer.fromJson(Map<String, dynamic> json) => ForumTextAnswer(
    forum: json["forum"],
    text: json["text"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "forum": forum,
    "text": text,
    "user": user,
  };
}