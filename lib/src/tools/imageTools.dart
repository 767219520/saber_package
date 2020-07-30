import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as flutterui;
import 'dart:ui';

import 'package:flutter/painting.dart' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart' as ui;
import 'package:flutter/services.dart' as service;

class ImageLoader {
  static service.AssetBundle getAssetBundle() => (service.rootBundle != null)
      ? service.rootBundle
      : new service.NetworkAssetBundle(new Uri.directory(Uri.base.origin));

//  static Future<flutterui.Image> load(String path) async {
//    ui.ImageStream stream = new ui.AssetImage(path, bundle: getAssetBundle())
//        .resolve(ui.ImageConfiguration.empty);
//    Completer<flutterui.Image> completer = new Completer<flutterui.Image>();
//    ImageStreamListener listener=(ui.ImageInfo frame, bool synchronousCall) {
//      final flutterui.Image image = frame.image;
//      completer.complete(image);
//      stream.removeListener(listener);
//    };
//
//    stream.addListener(listener);
//    return completer.future;
//  }

  static String toBase64(Uint8List uint8List) {
    String image_base64 = base64Encode(uint8List);
    String r = "data:image/jpg;base64," + image_base64;
    return r;
  }

  static String toBase64WithoutSign(Uint8List uint8List) {
    return base64Encode(uint8List);
  }

  static Future<Uint8List> clipImage(
      Image image, Rect source, Rect dest) async {
    PictureRecorder _recorder = PictureRecorder();
    Canvas _canvas = Canvas(_recorder);
    _canvas.drawImageRect(image, source, dest, Paint());
    Image image1 = await _recorder
        .endRecording()
        .toImage(dest.width.toInt(), dest.height.toInt());
    ByteData byteData = await image1.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}
