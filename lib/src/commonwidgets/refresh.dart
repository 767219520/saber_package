import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresh extends StatefulWidget {
//  State<refresh> _controller;
  final OnRefresh onFooterRefresh;
  final OnRefresh onHeaderRefresh;
  IndexedWidgetBuilder widgetBuilder;
  int itemCount = 0;
  List<Widget> defaultChilds = null;
  bool firstRefresh;

  @override
  _refreshState createState() => _refreshState();

  Refresh(
      {this.onHeaderRefresh,
      this.onFooterRefresh,
      this.widgetBuilder,
      this.itemCount,
      this.defaultChilds,
      this.firstRefresh = true});
}

class _refreshState extends State<Refresh> {
  EasyRefresh _smartRefresher;
//
//  GlobalKey<EasyRefreshState> _easyRefreshKey =
//      new GlobalKey<EasyRefreshState>();
//  GlobalKey<RefreshHeaderState> _headerKey =
//      new GlobalKey<RefreshHeaderState>();
//  GlobalKey<RefreshFooterState> _footerKey =
//      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    widget.itemCount = widget.itemCount <= 0 ? 0 : widget.itemCount;
    _smartRefresher = new EasyRefresh(
        firstRefresh: widget.firstRefresh,
//        key: _easyRefreshKey,
        header: BezierCircleHeader(
//          key: _headerKey,
          backgroundColor: Color(0xFFdddddd),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        footer: BezierBounceFooter(
//          key: _footerKey,
          backgroundColor: Color(0xFFdddddd),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        onRefresh: widget.onHeaderRefresh == null
            ? null
            : () {
                return _onRefresh(true);
              },
        onLoad: widget.onFooterRefresh == null
            ? null
            : () {
                return _onRefresh(false);
              },
        child: widget.widgetBuilder == null
            ? ListView(
                children: widget.defaultChilds,
                physics: BouncingScrollPhysics(),
              )
            : ListView.builder(
                itemCount: widget.itemCount,
                itemBuilder: widget.widgetBuilder,
                physics: BouncingScrollPhysics()));
    return _smartRefresher;
  }

  Future<void> _onRefresh(bool up) {
    if (up)
      return widget.onHeaderRefresh(this);
    else
      return widget.onFooterRefresh(this);
  }
}

typedef Future OnRefresh(State controller);
