import 'dart:convert';

PostToken postTokenFromJson(String str) => PostToken.fromJson(json.decode(str));

String postTokenToJson(PostToken data) => json.encode(data.toJson());

class PostToken {
  PostToken({
    this.pushToken,
  });

  String pushToken;

  factory PostToken.fromJson(Map<String, dynamic> json) => PostToken(
    pushToken: json["push_token"],
  );

  Map<String, dynamic> toJson() => {
    "push_token": pushToken,
  };
}