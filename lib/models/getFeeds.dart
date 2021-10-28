// import 'dart:convert';
//
// Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));
//
// String feedToJson(Feed data) => json.encode(data.toJson());
//
// class Feed {
//   Feed({
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
//   factory Feed.fromJson(Map<String, dynamic> json) => Feed(
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
//     this.feedImages,
//     this.title,
//     this.text,
//     this.createdAt,
//   });
//
//   int id;
//   List<FeedImage> feedImages;
//   String title;
//   String text;
//   DateTime createdAt;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         feedImages: List<FeedImage>.from(
//             json["feed_images"].map((x) => FeedImage.fromJson(x))),
//         title: json["title"],
//         text: json["text"],
//         createdAt: DateTime.parse(json["created_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "feed_images": List<dynamic>.from(feedImages.map((x) => x.toJson())),
//         "title": title,
//         "text": text,
//         "created_at": createdAt.toIso8601String(),
//       };
// }
//
// class FeedImage {
//   FeedImage({
//     this.image,
//     this.isMain,
//   });
//
//   String image;
//   bool isMain;
//
//   factory FeedImage.fromJson(Map<String, dynamic> json) => FeedImage(
//         image: json["image"],
//         isMain: json["is_main"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "image": image,
//         "is_main": isMain,
//       };
// }




// import 'dart:convert';
//
// Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));
//
// String feedToJson(Feed data) => json.encode(data.toJson());
//
// class Feed {
//   Feed({
//     this.id,
//     this.feedImages,
//     this.title,
//     this.text,
//     this.createdAt,
//   });
//
//   int id;
//   List<FeedImage> feedImages;
//   String title;
//   String text;
//   DateTime createdAt;
//
//   factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//     id: json["id"],
//     feedImages: List<FeedImage>.from(json["feed_images"].map((x) => FeedImage.fromJson(x))),
//     title: json["title"],
//     text: json["text"],
//     createdAt: DateTime.parse(json["created_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "feed_images": List<dynamic>.from(feedImages.map((x) => x.toJson())),
//     "title": title,
//     "text": text,
//     "created_at": createdAt.toIso8601String(),
//   };
// }
//
// class FeedImage {
//   FeedImage({
//     this.image,
//     this.isMain,
//   });
//
//   String image;
//   bool isMain;
//
//   factory FeedImage.fromJson(Map<String, dynamic> json) => FeedImage(
//     image: json.containsKey("image") ? json["image"] : "",
//     isMain: json.containsKey("is_main") ? json["is_main"] : "",
//   );
//
//   Map<String, dynamic> toJson() => {
//     "image": image,
//     "is_main": isMain,
//   };
// }

// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));

String feedToJson(Feed data) => json.encode(data.toJson());

class Feed {
  Feed({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
