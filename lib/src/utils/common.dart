import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common {
//  static Size screenSize = Size(0, 0);
  static void printLog(dynamic text) {
    print("日志:" + text.toString());
  }

  static T packaging<T extends Object>(T o) {
    return o;
  }



  static Rect getCenterRect(Rect rect, Size centerSize) {
    double left = (rect.width - centerSize.width) / 2;
    double top = (rect.height - centerSize.height) / 2;
    var r = Rect.fromLTWH(left, top, centerSize.width, centerSize.height);
    return r;
  }

  static Rect getRectFromEnterCenter(Rect rectCenter) {
    double w = rectCenter.left * 2 + rectCenter.width;
    double h = rectCenter.top * 2 + rectCenter.height;
    return Rect.fromLTWH(0, 0, w, h);
  }

  static Rect getScaleRect(Rect rect, double scale) {
    return Rect.fromLTWH(rect.left * scale, rect.top * scale,
        rect.width * scale, rect.height * scale);
  }




}
