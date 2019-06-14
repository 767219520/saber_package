import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteTools {
  static void pagegoBack<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).pop(result);
  }

  static Future pageTurn(BuildContext context, Widget page,
      [bool destroy = false, bool autoPlatform = false]) {
    var r;
    if (autoPlatform && Platform.isIOS) {
      r = CupertinoPageRoute(builder: (context) {
        return page;
      });
    } else {
      r = MaterialPageRoute(builder: (context) {
        return page;
      });
    }

    if (!destroy) return Navigator.of(context).push(r);
    return Navigator.of(context)
        .pushAndRemoveUntil(r, (route) => route == null);
  }
}
