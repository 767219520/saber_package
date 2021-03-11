import 'package:flutter/material.dart';
import 'package:saber_package/src/tools/common_tools.dart';

class FutureBuilderWidget extends StatefulWidget {
  WidgetBuilderResult _widgetBuilder;
  FutureBuilderController controller;
  Key key;
  Function afterInit;
  FutureInit _init;

  FutureBuilderWidget(@required this._widgetBuilder, @required this._init,
      @required this.controller,
      {this.key});

  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  Future _init(BuildContext context) {
    return widget._init(context).then((value) {
      widget.controller.isload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget c = widget.controller.isload
        ? widget._widgetBuilder(context, null)
        : FutureBuilder(
            key: widget.key,
            future: _init(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (ConnectionState.done == snapshot.connectionState) {
                return widget._widgetBuilder(context, snapshot.data);
              }
              return Container(
                  color: Colors.white,
                  child: CommonTools.loadingWidgetSingle(context));
            });
    return c;
  }

  @override
  void initState() {
    super.initState();
//    WidgetsBinding.instance.addObserver(this);
    widget.controller._state = this;
    widget.controller.isload = false;
  }

  @override
  void dispose() {
    super.dispose();
//    WidgetsBinding.instance.removeObserver(this);
  }
}

class FutureBuilderController {
  bool isload = false;
  State _state;

  void reset() {
    isload = false;
    if (_state.mounted) _state.setState(() {});
  }

  void setState() {
    if (isload && _state.mounted) _state.setState(() {});
  }
}

typedef Future FutureInit(BuildContext context);

typedef Widget WidgetBuilderResult(BuildContext context, dynamic data);
