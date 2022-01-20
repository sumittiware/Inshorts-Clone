// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:inshort_clone/controller/provider.dart';
import 'package:share_plus/share_plus.dart';

void convertWidgetToImageAndShare(BuildContext context, containerKey) async {
  RenderRepaintBoundary renderRepaintBoundary =
      containerKey.currentContext.findRenderObject();
  final filename = (await getApplicationDocumentsDirectory()).path +
      DateTime.now().toString() +
      ".jpg";
  ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
  ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
  Uint8List uInt8List = byteData.buffer.asUint8List();
  File saveFile = File(filename);
  await saveFile.writeAsBytes(uInt8List);
  try {
    await Share.shareFiles([filename],
        text:
            'This message sent from *inshorts Clone* made by *Sumit Tiware*\nFork this repository on *Github*\n\n https://github.com/sumittiware/Inshorts-Clone.');
  } catch (e) {
    print('error: $e');
  }

  Provider.of<FeedProvider>(context, listen: false).setWatermarkVisible(false);
}
