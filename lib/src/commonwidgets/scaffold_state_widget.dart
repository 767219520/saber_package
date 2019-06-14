import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScaffoldStateWidget extends StatefulWidget {
  ScaffoldStateController controller;
  ScaffoldStateWidget({@required this.controller});

  @override
  _ScaffoldStateWidgetState createState() => _ScaffoldStateWidgetState();
}

class _ScaffoldStateWidgetState extends State<ScaffoldStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }

  @override
  void initState() {
    super.initState();
    widget.controller._state=this;
    widget.controller._context = context;
  }
}

class ScaffoldStateController {
  BuildContext _context;
  State _state;

  ScaffoldStateController();
  ScaffoldState getScaffoldState() {
     if(_state.mounted) return Scaffold.of(_context);
  }
}
