// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inshort_clone/view/photo_view/photo_expanded_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:inshort_clone/aplication_localization.dart';
import 'package:inshort_clone/controller/provider.dart';
import 'package:inshort_clone/controller/settings.dart';
import 'package:inshort_clone/global/global.dart';
import 'package:inshort_clone/model/news_model.dart';
import 'package:inshort_clone/services/news/offline_service.dart';
import 'package:inshort_clone/style/colors.dart';
import 'package:inshort_clone/style/text_style.dart';
import 'bottom_action_bar.dart';
import 'bottom_bar.dart';

class NewsCard extends StatelessWidget {
  final Articles article;
  final bool isFromSearch;

  const NewsCard({Key key, this.article, this.isFromSearch}) : super(key: key);

  @override
  build(BuildContext context) {
    final provider = Provider.of<FeedProvider>(context, listen: false);

    provider.setNewsURL(article.url);
    removeArticleFromUnreads(article);

    print(article.url);

    return GestureDetector(
      onTap: () {
        provider.setAppBarVisible(!provider.getAppBarVisible);
        provider.setSearchAppBarVisible(!provider.getSearchAppBarVisible);
        provider.setFeedBottomActionbarVisible(
            !provider.getFeedBottomActionbarVisible);
      },
      child: SafeArea(
        bottom: false,
        child: _buildCard(context, provider),
      ),
    );
  }

  Widget _buildCard(BuildContext context, provider) {
    GlobalKey _containerKey = GlobalKey();

    return Consumer<FeedProvider>(builder: (context, value, _) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            minHeight: Global.height(context),
            minWidth: double.maxFinite,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.3),
          ),
          child: RepaintBoundary(
            key: _containerKey,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.4,
                    child: article.urlToImage != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ExpandedImageView(
                                    image: article.urlToImage);
                              }));
                            },
                            child: Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                                imageUrl: article.urlToImage,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.6,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.85,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                            child: WatchBoxBuilder(
                              box: Hive.box<Articles>('bookmarks'),
                              builder: (context, box) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => handleBookmarks(article),
                                    child: Text(
                                      article.title,
                                      style: box.containsKey(article.url)
                                          ? AppTextStyle.newsTitle
                                              .copyWith(color: AppColor.accent)
                                          : AppTextStyle.newsTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    article.content != null
                                        ? article.content
                                        : "",
                                    style: AppTextStyle.newsSubtitle,
                                    overflow: TextOverflow.fade,
                                    maxLines: 9,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "${article.author}",
                                    style: AppTextStyle.newsFooter,
                                  ),
                                  Text(
                                    "${article.date}  ${article.time}",
                                    style: AppTextStyle.newsFooter,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.15,
                          child: BottomBar(
                            articles: article,
                          ),
                        ),
                        value.getFeedBottomActionbarVisible
                            ? FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.15,
                                child: BottomActionBar(
                                  containerKey: _containerKey,
                                  articles: article,
                                ))
                            : Container(),
                        value.getWatermarkVisible
                            ? FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.17,
                                child: Material(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Consumer<SettingsProvider>(
                                              builder:
                                                  (context, theme, child) =>
                                                      FaIcon(
                                                FontAwesomeIcons.github,
                                                size: 20,
                                                color: theme.isDarkThemeOn
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text("github/sumittiware"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/logo.png",
                                              height: 20,
                                              width: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Inshorts Clone"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
