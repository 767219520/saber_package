import 'package:flutter/material.dart';

class KeepAliveState extends StatefulWidget {

  Widget _child;

  KeepAliveState( this._child);

  @override
  _KeepAliveStateState createState() => _KeepAliveStateState();
}

class _KeepAliveStateState extends State<KeepAliveState> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget._child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
