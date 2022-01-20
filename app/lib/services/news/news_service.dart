// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:inshort_clone/controller/settings.dart';
import 'package:inshort_clone/global/global.dart';
import 'package:provider/provider.dart';

// Project imports:

import 'package:inshort_clone/controller/provider.dart';
import 'package:inshort_clone/model/news_model.dart';
import 'package:inshort_clone/services/news/offline_service.dart';

abstract class NewsFeedRepository {
  Future<List<Articles>> getNewsByCategory(String category);
  List<Articles> getNewsFromLocalStorage(String box);
}

class NewsFeedRepositoryImpl implements NewsFeedRepository {
  final BuildContext context;
  NewsFeedRepositoryImpl(this.context);

  @override
  Future<List<Articles>> getNewsByCategory(String category) async {
    final provider = Provider.of<FeedProvider>(context, listen: false);
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final String url =
        "${Global.serverUrl}?lang=${settings.localeCode}&category=$category";

    provider.setDataLoaded(false);
    provider.setLastGetRequest("getNewsByTopic", category);

    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      List<Articles> articles =
          NewsModel.fromJson(response.data).articles ?? [];

      provider.setDataLoaded(true);
      addArticlesToUnreads(articles);

      return articles;
    } else {
      provider.setDataLoaded(true);
      throw Exception();
    }
  }

  @override
  List<Articles> getNewsFromLocalStorage(String fromBox) {
    List<Articles> articles = [];
    final Box<Articles> hiveBox = Hive.box<Articles>(fromBox);
    final provider = Provider.of<FeedProvider>(context, listen: false);

    provider.setLastGetRequest("getNewsFromLocalStorage", fromBox);

    print(fromBox);

    if (hiveBox.length > 0) {
      for (int i = 0; i < hiveBox.length; i++) {
        Articles article = hiveBox.getAt(i);
        articles.add(article);
      }
      provider.setDataLoaded(true);

      return articles;
    } else {
      provider.setDataLoaded(true);
      List<Articles> articles = [];
      return articles;
    }
  }
}
