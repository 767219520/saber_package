import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saber_package/src/tools/toast_tools.dart';

class WillPopScopeWidget extends StatelessWidget {
  Widget child;
  int _lastClickTime = 0;

  WillPopScopeWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: _doubleExit,
    );
  }

  Future<bool> _doubleExit() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(true);
    } else {
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      ToastTools.showShort("再点一次退出");
      return Future.value(false);
    }
  }
}
