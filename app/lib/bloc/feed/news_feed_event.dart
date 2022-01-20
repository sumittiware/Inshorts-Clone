// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

abstract class NewsFeedEvent extends Equatable {}

class FetchNewsByCategoryEvent extends NewsFeedEvent {
  final String category;
  FetchNewsByCategoryEvent({@required this.category});

  List<Object> get props => [category];
}

class FetchNewsFromLocalStorageEvent extends NewsFeedEvent {
  final String box;
  FetchNewsFromLocalStorageEvent({@required this.box});

  List<Object> get props => [box];
}
