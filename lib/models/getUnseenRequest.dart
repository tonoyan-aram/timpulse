import 'dart:convert';

GetUnseenRequest getUnseenRequestFromJson(String str) => GetUnseenRequest.fromJson(json.decode(str));

String getUnseenRequestToJson(GetUnseenRequest data) => json.encode(data.toJson());

class GetUnseenRequest {
  GetUnseenRequest({
    this.count,
  });

  int count;

  factory GetUnseenRequest.fromJson(Map<String, dynamic> json) => GetUnseenRequest(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
