import 'package:flutter/material.dart';
import 'package:saber_package/src/tools/common_tools.dart';

class FutureBuilderWidget extends StatefulWidget {
  WidgetBuilder _widgetBuilder;
  FutureBuilderController controller;
  FutureBuilderWidget(@required this._widgetBuilder, @required this._init,
      @required this.controller);

  FutureInit _init;

  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  Future init() {
    return widget._init(context).then((v){
      widget.controller.isload=true;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget c = widget.controller.isload
        ? widget._widgetBuilder(context)
        : FutureBuilder(
            future: init(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (ConnectionState.done == snapshot.connectionState){
                return widget._widgetBuilder(context);
              }
              return Container(
                  color: Colors.white,
                  child: CommonTools.loadingWidgetSingle(context));
            });
    return c;
  }

  @override
  void initState() {
    widget.controller._state = this;
    widget.controller.isload=false;
  }
}

class FutureBuilderController {
  bool isload = false;
  State _state;

  void reset() {
    isload = false;
    if (_state.mounted) _state.setState(() {});
  }
}

typedef Future FutureInit(BuildContext context);