import 'dart:convert';

AnswerRequest answerRequestFromJson(String str) => AnswerRequest.fromJson(json.decode(str));

String answerRequestToJson(AnswerRequest data) => json.encode(data.toJson());

class AnswerRequest {
  AnswerRequest({
    this.answer,
  });

  String answer;

  factory AnswerRequest.fromJson(Map<String, dynamic> json) => AnswerRequest(
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "answer": answer,
  };
}