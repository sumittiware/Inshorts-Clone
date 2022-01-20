// Flutter imports:
import 'package:flutter/cupertino.dart';

class Global {
  static final List<String> lang = [
    "English",
    "हिंदी",
  ];
  static height(context) => MediaQuery.of(context).size.height;
  static width(context) => MediaQuery.of(context).size.width;
  static String serverUrl = "http://server_ip-address:port/api/";
}
