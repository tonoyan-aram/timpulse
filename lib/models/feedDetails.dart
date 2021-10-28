

import 'dart:convert';

FeedDetails feedDetailsFromJson(String str) => FeedDetails.fromJson(json.decode(str));

String feedDetailsToJson(FeedDetails data) => json.encode(data.toJson());

class FeedDetails {
  FeedDetails({
    this.id,
    this.feedImages,
    this.title,
    this.text,
    this.createdAt,
  });

  int id;
  List<FeedImage> feedImages;
  String title;
  String text;
  DateTime createdAt;

  factory FeedDetails.fromJson(Map<String, dynamic> json) => FeedDetails(
    id: json["id"],
    feedImages: List<FeedImage>.from(json["feed_images"].map((x) => FeedImage.fromJson(x))),
    title: json["title"],
    text: json["text"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "feed_images": List<dynamic>.from(feedImages.map((x) => x.toJson())),
    "title": title,
    "text": text,
    "created_at": createdAt.toIso8601String(),
  };
}

class FeedImage {
  FeedImage({
    this.image,
    this.isMain,
  });

  String image;
  bool isMain;

  factory FeedImage.fromJson(Map<String, dynamic> json) => FeedImage(
    image: json["image"],
    isMain: json["is_main"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "is_main": isMain,
  };
}
