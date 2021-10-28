import 'dart:convert';

PostRequest postRequestFromJson(String str) => PostRequest.fromJson(json.decode(str));

String postRequestToJson(PostRequest data) => json.encode(data.toJson());

class PostRequest {
  PostRequest({
    this.staffRole,
    this.title,
    this.text,
    this.file,
    this.author,
    this.userId,
  });

  int author;
  String title;
  String file;
  int staffRole;
  String text;
  int userId;



  factory PostRequest.fromJson(Map<String, dynamic> json) => PostRequest(
    author: json["author"],
    title: json["title"],
    file: json["file"],
    staffRole: json["staff_role"],
    text: json["text"],
    userId: json["attache_to_by_user"]


  );

  Map<String, dynamic> toJson() => {
    "author":author,
    "title": title,
    "file":file,
    "staff_role": staffRole,
    "text": text,
    "attache_to_by_user" : userId
  };
}
