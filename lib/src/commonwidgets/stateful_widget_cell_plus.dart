import 'package:flutter/cupertino.dart';
import 'package:saber_package/src/utils/common.dart';

class StatefulWidgetCellPlus extends StatefulWidget {
  StatefulWidgetController controller;
  Widget child;
  GestureTapCallback onTap;
  bool disableBack;
  bool hide;
  double opacity;
  WidgetBuilder widgetBuilder;

  StatefulWidgetCellPlus(
      {Key key,
      this.controller,
      this.child,
      this.widgetBuilder,
      this.disableBack = false,
      this.opacity = 1,
      this.hide = false})
      : super(key: key);

  @override
  _StatefulWidgetCellStatePlus createState() => _StatefulWidgetCellStatePlus();
}

class _StatefulWidgetCellStatePlus extends State<StatefulWidgetCellPlus> {
  WidgetsBinding widgetsBinding;
  VoidCallback listener;
  bool _forcedRefresh = false;

  @override
  Widget build(BuildContext context) {
    if (listener != null) {
      widgetsBinding.addPostFrameCallback((v) {
        var _listener = listener;
        listener = null;
        _listener();
      });
    }
    if (_forcedRefresh) return Text("");
    if (widget.hide) return Offstage(offstage: true);
    var w = widget.child;
    if (widget.widgetBuilder != null) w = widget.widgetBuilder(context);
    if (widget.opacity < 1) w = Opacity(child: w, opacity: widget.opacity);
    if (widget.onTap != null)
      w = GestureDetector(child: w, onTap: widget.onTap);
    if (widget.disableBack) {
      w = WillPopScope(
          child: w,
          onWillPop: () {
            return Future.value(false);
          });
    }
    return w;
  }

  @override
  void initState() {
    widgetsBinding = WidgetsBinding.instance;
    if (widget.controller != null) {
      widget.controller._state = this;
      widget.controller._context = context;
    }
    Common.printLog("key${widget.key.toString()}创建");
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class StatefulWidgetController {
  _StatefulWidgetCellStatePlus _state;
  BuildContext _context;

  BuildContext getContext() {
    return _context;
  }

  State getState() {
    return _state;
  }

  void dispatch([VoidCallback listener = null]) {
    if (_state != null) {
      _state.listener = listener;
      if (_state.mounted) _state.setState(() {});
    }
  }

  void forcedUnload([VoidCallback back]) {
    _state._forcedRefresh = true;
    dispatch(() {
      _state._forcedRefresh = false;
      if (back != null) back();
    });
  }

  void dispose() {
    if (_state != null) _state.dispose();
    _state = null;
  }
}
