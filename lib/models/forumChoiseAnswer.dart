import 'dart:convert';

ForumChoiseAnswer forumChoiseAnswerFromJson(String str) => ForumChoiseAnswer.fromJson(json.decode(str));

String forumChoiseAnswerToJson(ForumChoiseAnswer data) => json.encode(data.toJson());

class ForumChoiseAnswer {
  ForumChoiseAnswer({
    this.forum,
    this.choice,
    this.user,
  });

  int forum;
  int choice;
  int user;

  factory ForumChoiseAnswer.fromJson(Map<String, dynamic> json) => ForumChoiseAnswer(
    forum: json["forum"],
    choice: json["choice"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "forum": forum,
    "choice": choice,
    "user": user,
  };
}