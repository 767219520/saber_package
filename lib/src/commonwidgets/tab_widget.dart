import 'package:flutter/material.dart';

import 'keep_alive_state.dart';

class TabWidget extends StatefulWidget {
  @override
  _TabWidgetState createState() => _TabWidgetState();
  List<Widget> tabBar = [];
  List<Widget> tabview = [];
  Widget tabLeft = null;
  TextStyle style;
  Color color;
  Color selectColor;
  Color indicatorColor;
  Alignment alignment;
  Decoration decoration;
  EdgeInsetsGeometry padding;
  ValueChanged<int> onChanged;

  TabWidget(
      {this.tabBar,
      this.decoration,
      this.padding,
      this.tabview,
      this.color,
      this.selectColor,
      this.style,
      this.alignment = Alignment.centerLeft,
      this.tabLeft,
      this.indicatorColor,
      this.onChanged})
      : super(key: Key(tabBar.length.toString())){
  }
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  Widget build(BuildContext context) {
    if (widget.tabBar.length != widget.tabview.length) return Container();
    if (widget.tabBar.length <= 0) return Container();
    List<Tab> tabs =
        widget.tabBar.map((Widget tab) => Tab(child: tab)).toList();
    List<Widget> views =
        widget.tabview.map((Widget tab) => KeepAliveState(tab)).toList();
    TabBar tabBar = TabBar(
        isScrollable: true,
        controller: mController,
        labelColor: widget.selectColor,
        unselectedLabelColor: widget.color,
        labelStyle: widget.style,
        indicatorColor: widget.indicatorColor,
        tabs: tabs);
//    initData();
    var tabBarView = TabBarView(controller: mController, children: views);
    List<Widget> tabBars = [
      Expanded(
        child: Container(
          child: tabBar,
          alignment: widget.alignment,
        ),
      )
    ];
    if (widget.tabLeft != null) {
      tabBars.add(widget.tabLeft);
    }
    return Column(children: [
      Container(
          child: Row(children: tabBars),
          padding: widget.padding,
          decoration: widget.decoration),
      Expanded(child: tabBarView)
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  void initState() {
    updateController();
  }

  void onChanged() {
    if (widget.onChanged != null) widget.onChanged(mController.index);
  }

  void updateController() {
    mController = TabController(
      length: widget.tabBar.length,
      vsync: this,
    );
    mController.addListener(onChanged);
  }
}
