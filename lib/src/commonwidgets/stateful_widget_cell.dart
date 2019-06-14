import 'package:flutter/cupertino.dart';

typedef void StatefulWidgetOnTap(
    State<StatefulWidgetCell> state, Widget widget);

class StatefulWidgetCell extends StatefulWidget {
  WidgetBuilder widgetBuilder;
  StatefulController controller;

  StatefulWidgetCell({this.widgetBuilder, @required this.controller});

  @override
  _StatefulWidgetCellState createState() => _StatefulWidgetCellState();
}

class _StatefulWidgetCellState extends State<StatefulWidgetCell> {
  @override
  Widget build(BuildContext context) {
    Widget c = widget.widgetBuilder(context);
    return c;
  }

  @override
  void initState() {
    widget.controller._state = this;
  }
}

class StatefulController {
  _StatefulWidgetCellState _state;
  BuildContext _context;

  BuildContext getContext() {
    return _context;
  }

  State getState() {
    return _state;
  }

  void dispatch() {
    if (_state != null&&_state.mounted) {
      _state.setState(() {});
    }
  }

  void dispose() {
    if (_state != null&&_state.mounted) _state.dispose();
    _state = null;
  }
}
