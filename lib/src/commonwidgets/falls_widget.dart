import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Falls extends StatelessWidget {
  int itemCount = 0;
  int rowCount = 0;
  double bottomMargin = 0;
  double rightMargin = 0;
  IndexedWidgetBuilder itemBuilder;
  SpanWidgetBuilder spanitemBuilder;

  Falls(
      {this.itemCount = 0,
      this.rowCount = 0,
      this.bottomMargin = 0,
      this.rightMargin = 0,
      this.itemBuilder,
      this.spanitemBuilder}) {
    this.itemBuilder = this.itemBuilder ??
        (BuildContext context, int index) {
          return Container();
        };
    this.spanitemBuilder = this.spanitemBuilder ??
        (BuildContext context, int index) {
          return Staggered(1, 1);
        };
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 0 || rowCount <= 0) return Container();
    var flow = new StaggeredGridView.countBuilder(
      crossAxisCount: rowCount,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      staggeredTileBuilder: (int index) {
        var span = spanitemBuilder(context, index);
        return StaggeredTile.count(span.rowSpan, span.colSpan);
      },
      mainAxisSpacing: bottomMargin,
      crossAxisSpacing: rightMargin,
    );
    return flow;
  }

  Widget build1(BuildContext context) {
    if (itemCount <= 0 || rowCount <= 0) return Container();
    var flow = new StaggeredGridView.extentBuilder(
      maxCrossAxisExtent:200 ,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      staggeredTileBuilder: (int index) {
        var span = spanitemBuilder(context, index);
        return StaggeredTile.count(span.rowSpan, span.colSpan);
      },
      mainAxisSpacing: bottomMargin,
      crossAxisSpacing: rightMargin,
    );
    return flow;
  }
}

class Staggered {
  int rowSpan = 0;
  int colSpan = 0;

  Staggered(this.rowSpan, this.colSpan);
}

typedef SpanWidgetBuilder = Staggered Function(BuildContext context, int index);
