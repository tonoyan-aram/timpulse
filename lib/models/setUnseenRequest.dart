import 'dart:convert';

SetUnseenRequest setUnseenRequestFromJson(String str) => SetUnseenRequest.fromJson(json.decode(str));

String setUnseenRequestToJson(SetUnseenRequest data) => json.encode(data.toJson());

class SetUnseenRequest {
  SetUnseenRequest({
    this.message,
  });

  String message;

  factory SetUnseenRequest.fromJson(Map<String, dynamic> json) => SetUnseenRequest(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}