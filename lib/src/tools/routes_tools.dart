import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saber_package/saber_utils.dart';
import 'package:saber_package/src/adapter/base_page.dart';

class Routes {
  static FluroRouter _router;

  static void configureRoutes(List<RouteConfig> lstConfig) {
    _router = new FluroRouter();
    _router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）

    for (var config in lstConfig) {
      var handler = new Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        String p = params["p"]?.first;
        Map<String, dynamic> paramsMap = null;
        if (!StringUtils.isEmpty(p)) {
          paramsMap = json.decode(FluroConvertUtils.fluroCnParamsDecode(p));
        }
        return config.setPage().initWith(paramsMap);
      });
      _router.define(config.routeName, handler: handler);
    }
  }

  static Future navigateTo(BuildContext context, String routerName,
      {Map<String, dynamic> paramsMap,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition=TransitionType.cupertino,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    var realRouterName = !routerName.contains("?")
        ? routerName
        : routerName.substring(0, routerName.indexOf("?"));
    var queryString = !routerName.contains("?")
        ? ""
        : routerName.substring(routerName.indexOf("?") + 1);
    Uri uri = new Uri(
        scheme: 'http',
        host: 'localhost',
        path: realRouterName,
        query: queryString);

    if (paramsMap != null) {
      paramsMap.addAll(uri.queryParameters);
      realRouterName +=
          "?p=" + FluroConvertUtils.fluroCnParamsEncode(json.encode(paramsMap));
    } else {
      realRouterName += "?p=" +
          FluroConvertUtils.fluroCnParamsEncode(
              json.encode(uri.queryParameters));
    }
    return _router.navigateTo(context, realRouterName,
        replace: replace,
        clearStack: clearStack,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder);
  }

  static void back<T extends Object>(BuildContext context, [T result]) {
    return Navigator.pop(context, result);
  }

//  static Future pageTurn(BuildContext context, Widget page,
//      [bool destroy = false, bool autoPlatform = false]) {
//    var r;
//    if (autoPlatform && Platform.isIOS) {
//      r = CupertinoPageRoute(builder: (context) {
//        return page;
//      });
//    } else {
//      r = MaterialPageRoute(builder: (context) {
//        return page;
//      });
//    }
//
//    if (!destroy) return Navigator.of(context).push(r);
//    return Navigator.of(context)
//        .pushAndRemoveUntil(r, (route) => route == null);
//  }
}

class RouteConfig {
  String routeName;
  SetPage setPage;
  bool pointerParams;

  RouteConfig(this.routeName, this.setPage, [this.pointerParams = false]);
}

class FluroConvertUtils {
  /// fluro 传递中文参数前，先转换，fluro 不支持中文传递
  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  /// fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    var list = List<int>();

    ///字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  /// string 转为 int
  static int string2int(String str) {
    return int.parse(str);
  }

  /// string 转为 double
  static double string2double(String str) {
    return double.parse(str);
  }

  /// string 转为 bool
  static bool string2bool(String str) {
    if (str == 'true') {
      return true;
    } else {
      return false;
    }
  }

  /// object 转为 string json
  static String object2string<T>(T t) {
    return fluroCnParamsEncode(jsonEncode(t));
  }

  /// string json 转为 map
  static Map<String, dynamic> string2map(String str) {
    return json.decode(fluroCnParamsDecode(str));
  }
}

typedef BasePage SetPage();
