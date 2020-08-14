import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:saber_package/src/utils/common.dart';

class StatefulWidgetCellPlus extends StatefulWidget {
  StatefulWidgetController controller;
  Widget child;
//  Key key;

  StatefulWidgetCellPlus(
//    this.key,
      @required this.controller,
      @required this.child,
      );

  @override
  _StatefulWidgetCellStatePlus createState() => _StatefulWidgetCellStatePlus();
}

class _StatefulWidgetCellStatePlus extends State<StatefulWidgetCellPlus>  with WidgetsBindingObserver {
  WidgetsBinding widgetsBinding;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    widgetsBinding = WidgetsBinding.instance;
    widget.controller._state = this;
    widget.controller._context = context;
    widgetsBinding.addPostFrameCallback((v){
      widget.controller.frameCallback(context,v);
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁观察者
  }
}

class StatefulWidgetController {
  _StatefulWidgetCellStatePlus _state;
  BuildContext _context;
  Function frameCallback;

  StatefulWidgetController(@required this.frameCallback);

  BuildContext getContext() {
    return _context;
  }

  State getState() {
    return _state;
  }

}
