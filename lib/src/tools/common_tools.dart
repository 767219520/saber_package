import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'route_tools.dart';

class CommonTools {
  static showloading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: SpinKitCircle(color: Color(0xffd59e0b), size: 50.0));
        });
  }

  static Widget loadingWidget(@required BuildContext context) {
    return Scaffold(
        body:
            Center(child: SpinKitCircle(color: Color(0xffd59e0b), size: 50.0)));
  }

  static Widget loadingWidgetSingle(@required BuildContext context) {
    return SpinKitCircle(color: Color(0xffd59e0b), size: 50.0);
  }

  static showConfirm(BuildContext context, String title, String msg,
      {String confirmTitle = "确定", String cancleTitle = "取消"}) {
    var ac = CupertinoAlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(confirmTitle),
          isDefaultAction: true,
          onPressed: () {
            RouteTools.pagegoBack(context, true);
          },
        ),
        CupertinoDialogAction(
          child: Text(cancleTitle),
          isDestructiveAction: true, //true为红色，false为蓝色
          isDefaultAction: true, //true为粗体，false为正常
          onPressed: () {
            RouteTools.pagegoBack(context, false);
          },
        ),
      ],
    );
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ac;
      },
    );
  }

  static Future showConfirmWidget(
      BuildContext context, String title, Widget msg,
      {String confirmTitle = "确定", String cancleTitle = "取消"}) {
    return showCupertinoDialog(
        context: context,
        builder: (context1) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Card(elevation: 0.0, child: msg),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  RouteTools.pagegoBack(context1, false);
                },
                child: Text(cancleTitle),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  RouteTools.pagegoBack(context1, true);
                },
                child: Text(confirmTitle),
              ),
            ],
          );
        });
  }

  static getscreenInfo(BuildContext context) {
    return MediaQuery.of(context);
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static alertDialog(
      BuildContext context, String title, Widget msg, Function func) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var ac = AlertDialog(
          title: new Text(title),
          content: msg,
          actions: <Widget>[
            Container(
              child: new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  func != null ? func(true) : null;
                  RouteTools.pagegoBack(context);
                },
              ),
            ),
          ],
        );
        return ac;
      },
    );
  }

  static refresh(State state) {
    if (state.mounted) state.setState(() {});
  }
}
