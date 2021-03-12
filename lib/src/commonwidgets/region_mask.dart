import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:saber_package/saber_utils.dart';

class RegiobMask extends StatefulWidget {
  @override
  _RegiobMaskState createState() => _RegiobMaskState();

  double regionWidthDp = 0.0;
  double regionHeightDp = 0.0;
  double top;

  Color color;

  Color regionColor;

  double opacity;
  WidgetBuilder widgetBuilderRegion;

  RegiobMask(
      {this.regionWidthDp = 100,
      this.regionHeightDp = 100,
      this.color = Colors.red,
      this.regionColor = Colors.transparent,
      this.opacity = 0.5,
      this.top = -1,
      this.widgetBuilderRegion});
}

class _RegiobMaskState extends State<RegiobMask> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenUtils.screenHeightDp;
    double screenWidth = ScreenUtils.screenWidthDp;
    return Container(
      child: ss(screenWidth, screenHeight),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget ss(screenWidth, screenHeight) {
    return Row(children: [
      getLeftRight(screenWidth, screenHeight),
      getRegion(screenWidth, screenHeight),
      getLeftRight(screenWidth, screenHeight)
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget getLeftRight(screenWidth, screenHeight) {
    return Container(
        width: (screenWidth - widget.regionWidthDp) / 2,
        height: screenHeight,
        color: (widget.color));
  }

  Widget getTopBottom(screenWidth, screenHeight, istop) {
    if (widget.top < 0) {
      return Container(
        height: (screenHeight - widget.regionHeightDp) / 2,
        width: widget.regionWidthDp,
        color: (widget.color),
      );
    }
    return Container(
      height: istop
          ? widget.top
          : screenHeight - widget.regionHeightDp - widget.top,
      width: widget.regionWidthDp,
      color: (widget.color),
    );
  }

  Widget getRegion(screenWidth, screenHeight) {
    return Column(children: [
      getTopBottom(screenWidth, screenHeight,true),
      Container(
        width: widget.regionWidthDp,
        height: widget.regionHeightDp,
        child: widget.widgetBuilderRegion(context),
        color: widget.regionColor,
      ),
      getTopBottom(screenWidth, screenHeight,false)
    ]);
  }
}
