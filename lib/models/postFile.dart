import 'dart:convert';

PostFile postFileFromJson(String str) => PostFile.fromJson(json.decode(str));

String postFileToJson(PostFile data) => json.encode(data.toJson());

class PostFile {
  PostFile({
    this.file,

  });

  String file;


  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
    file: json["file_url"],

  );

  Map<String, dynamic> toJson() => {
    "file_url": file,
  };
}