import 'dart:convert';
DeleteRequest deleteRequestFromJson(String str) => DeleteRequest.fromJson(json.decode(str));

String deleteRequestToJson(DeleteRequest data) => json.encode(data.toJson());

class DeleteRequest {
  DeleteRequest({
    this.id,

  });

  int id;


  factory DeleteRequest.fromJson(Map<String, dynamic> json) => DeleteRequest(
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,

  };
}