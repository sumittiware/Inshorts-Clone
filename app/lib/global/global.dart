// Flutter imports:
import 'package:flutter/cupertino.dart';

class Global {
  static final List<String> lang = [
    "English",
    "हिंदी",
  ];
  static height(context) => MediaQuery.of(context).size.height;
  static width(context) => MediaQuery.of(context).size.width;
  static String serverUrl = "http://192.168.43.220:8000/api/";
}
