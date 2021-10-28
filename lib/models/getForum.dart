// import 'dart:convert';
//
// ForumGet forumFromJson(String str) => ForumGet.fromJson(json.decode(str));
//
// String forumToJson(ForumGet data) => json.encode(data.toJson());
//
// class ForumGet {
//   ForumGet({
//     this.count,
//     this.next,
//     this.previous,
//     this.results,
//   });
//
//   int count;
//   dynamic next;
//   dynamic previous;
//   List<Result> results;
//
//   factory ForumGet.fromJson(Map<String, dynamic> json) => ForumGet(
//         count: json["count"],
//         next: json["next"],
//         previous: json["previous"],
//         results:
//             List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "count": count,
//         "next": next,
//         "previous": previous,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//       };
// }
//
// class Result {
//   Result({
//     this.id,
//     this.segment,
//     this.forumChoices,
//     this.text,
//     this.file,
//     this.replyType,
//     this.createdAt,
//     this.author,
//     this.endAt,
//   });
//
//   int id;
//   List<Segment> segment;
//   List<ForumChoice> forumChoices;
//   String text;
//   dynamic file;
//   String replyType;
//   DateTime createdAt;
//   DateTime endAt;
//
//   String author;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         segment:
//             List<Segment>.from(json["segment"].map((x) => Segment.fromJson(x))),
//         forumChoices: List<ForumChoice>.from(
//             json["forum_choices"].map((x) => ForumChoice.fromJson(x))),
//         text: json["text"],
//         file: json["file"],
//         replyType: json["reply_type"],
//         createdAt: DateTime.parse(json["created_at"]),
//         endAt: DateTime.parse(json["end_at"]),
//         author: json["author"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "segment": List<dynamic>.from(segment.map((x) => x.toJson())),
//         "forum_choices":
//             List<dynamic>.from(forumChoices.map((x) => x.toJson())),
//         "text": text,
//         "file": file,
//         "reply_type": replyType,
//         "created_at": createdAt.toIso8601String(),
//         "end_at" : endAt.toIso8601String(),
//         "author": author,
//       };
// }
//
// class ForumChoice {
//   ForumChoice({
//     this.id,
//     this.choice,
//     this.forum,
//   });
//
//   int id;
//   String choice;
//   int forum;
//
//   factory ForumChoice.fromJson(Map<String, dynamic> json) => ForumChoice(
//         id: json["id"],
//         choice: json["choice"],
//         forum: json["forum"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "choice": choice,
//         "forum": forum,
//       };
// }
//
//
//
// class Segment {
//   Segment({
//     this.id,
//     this.name,
//   });
//
//   int id;
//   String name;
//
//   factory Segment.fromJson(Map<String, dynamic> json) => Segment(
//         id: json["id"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }





// To parse this JSON data, do
//
//    final forum = forumFromJson(jsonString);



// Forum forumFromJson(String str) => Forum.fromJson(json.decode(str));
//
// String forumToJson(Forum data) => json.encode(data.toJson());
//
// class Forum {
//   Forum({
//     this.count,
//     this.next,
//     this.previous,
//     this.results,
//   });
//
//   int count;
//   String next;
//   String previous;
//   List<Result> results;
//
//   factory Forum.fromJson(Map<String, dynamic> json) => Forum(
//     count: json["count"],
//     next: json["next"],
//     previous: json["previous"],
//     results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "count": count,
//     "next": next,
//     "previous": previous,
//     "results": List<dynamic>.from(results.map((x) => x.toJson())),
//   };
// }
//
// class Result {
//   Result({
//     this.id,
//     this.segment,
//     this.forumChoices,
//     this.title,
//     this.file,
//     this.replyType,
//     this.createdAt,
//     this.endAt,
//     this.author,
//   });
//
//   int id;
//   List<Segment> segment;
//   List<ForumChoice> forumChoices;
//   String title;
//   String file;
//   String replyType;
//   DateTime createdAt;
//   DateTime endAt;
//   int author;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"],
//     segment:
//     List<Segment>.from(json["segment"].map((x) => Segment.fromJson(x))),
//     forumChoices: List<ForumChoice>.from(
//         json["forum_choices"].map((x) => ForumChoice.fromJson(x))),
//     title: json["text"],
//     file: json["file"],
//     replyType: json["reply_type"],
//     createdAt: DateTime.parse(json["created_at"]),
//     endAt: DateTime.parse(json["end_at"]),
//     author: json["author"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "segment": List<dynamic>.from(segment.map((x) => x.toJson())),
//     "forum_choices":
//     List<dynamic>.from(forumChoices.map((x) => x.toJson())),
//     "text": title,
//     "file": file,
//     "reply_type": replyType,
//     "created_at": createdAt.toIso8601String(),
//     "end_at": endAt.toIso8601String(),
//     "author": author,
//   };
// }
//
// class ForumChoice {
//   ForumChoice({
//     this.id,
//     this.choice,
//     this.forum,
//   });
//
//   int id;
//   String choice;
//   int forum;
//
//   factory ForumChoice.fromJson(Map<String, dynamic> json) => ForumChoice(
//     id: json["id"],
//     choice: json["choice"],
//     forum: json["forum"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "choice": choice,
//     "forum": forum,
//   };
// }
//
//
// class Segment {
//   Segment({
//     this.id,
//     this.name,
//   });
//
//   int id;
//   String name;
//
//   factory Segment.fromJson(Map<String, dynamic> json) => Segment(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }

// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

Forum forumFromJson(String str) => Forum.fromJson(json.decode(str));

String forumToJson(Forum data) => json.encode(data.toJson());

class Forum {
  Forum({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    "answered_by_me" : answeredByMe
  };
}

class ForumChoice {
  ForumChoice({
    this.id,
    this.choice,
    this.forum,
    this.answerSum,
  });

  int id;
  String choice;
  int forum;
  int answerSum;

  factory ForumChoice.fromJson(Map<String, dynamic> json) => ForumChoice(
    id: json["id"],
    choice: json["choice"],
    forum: json["forum"],
    answerSum: json["answer_sum"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "choice": choice,
    "forum": forum,
    "answer_sum":answerSum,
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
