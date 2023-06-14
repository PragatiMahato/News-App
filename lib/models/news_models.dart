import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleModel {
  SourceModel source;
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String? content;

  ArticleModel(
      {required this.source,
      required this.author,
      required this.content,
      required this.description,
      required this.publishedAt,
      required this.title,
      required this.url,
      required this.urlToImage});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromJson(json["source"]),
        title: json['title'],
        author: json['author'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt']),
        content: json["content"],
        url: json["url"],
      );
}

class SourceModel {
  String name;
  String? id;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json['id'],
        name: json['name'],
      );
}

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=bbe2798bef0d44eab0b9a83485a8e4c3";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            source: SourceModel.fromJson(element["source"]),
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"], url: element["url"],
            // articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
