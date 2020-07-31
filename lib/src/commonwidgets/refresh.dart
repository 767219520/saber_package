import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Refresh extends StatefulWidget {
  final OnRefresh onFooterRefresh;
  final OnRefresh onHeaderRefresh;
  IndexedWidgetBuilder widgetBuilder;
  SetItemCount itemCount;
  List<Widget> defaultChilds = null;
  bool firstRefresh;
  EasyRefreshController _controller;

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

  @override
  Widget build(BuildContext context) {
    var itemCount = widget.itemCount() ?? 0;
    _smartRefresher = new EasyRefresh(
        controller: widget._controller,
        firstRefresh: widget.firstRefresh,
        header: ClassicalHeader(
          refreshText: "上拉刷新",
          refreshReadyText: "释放刷新",
          refreshingText: "正在刷新中",
          refreshedText: "刷新完成",
          refreshFailedText: "刷新失败",
        ),
        footer: ClassicalFooter(
            loadText: "下拉加载",
            loadReadyText: "准备加载",
            loadingText: "加载中",
            loadedText: "加载完成",
            loadFailedText: "加载失败"),
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
                itemCount: itemCount,
                itemBuilder: widget.widgetBuilder,
                physics: BouncingScrollPhysics()));
    return _smartRefresher;
  }

  Future<void> _onRefresh(bool up) {
    if (up)
      return widget.onHeaderRefresh(this) ?? Future.value(null);
    else
      return widget.onFooterRefresh(this) ?? Future.value(null);
  }
}

typedef Future OnRefresh(State controller);
typedef int SetItemCount();
