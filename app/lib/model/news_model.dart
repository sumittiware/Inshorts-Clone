// Package imports:
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'news_model.g.dart';

class NewsModel {
  int status;
  int totalResults;
  List<Articles> articles;

  NewsModel({this.status, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        print("ll");
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 101)
class Articles {
  @HiveField(0)
  String author;
  @HiveField(1)
  String title;
  @HiveField(2)
  String readmoreUrl;
  @HiveField(3)
  String urlToImage;
  @HiveField(4)
  String date;
  @HiveField(5)
  String time;
  @HiveField(6)
  String content;
  @HiveField(7)
  String url;

  Articles(
      {this.author,
      this.title,
      this.date,
      this.url,
      this.urlToImage,
      this.time,
      this.content,
      this.readmoreUrl});

  Articles.fromJson(Map<String, dynamic> json) {
    author = json['author'] ?? "";
    title = json['title'] ?? "";
    url = json['url'] ?? "";
    urlToImage = json['imageUrl'] ?? "";
    date = json['date'] ?? "";
    content = json['content'] ?? "";
    time = json['time'] ?? "";
    readmoreUrl = json['readmoreUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['title'] = this.title;
    data['readmoreUrl'] = this.readmoreUrl;
    data['url'] = this.url;
    data['imageUrl'] = this.urlToImage;
    data['date'] = this.date;
    data['content'] = this.content;
    data['time'] = this.time;
    return data;
  }
}
