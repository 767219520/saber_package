import 'package:flutter/material.dart';

class ClipWidget extends StatelessWidget {
  Widget child;
  double height;
  double top;
  double width;
  double left;

  ClipWidget(
      {@required this.child,
      this.height: -1,
      this.top: 0,
      this.width: -1,
      this.left: 0});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: child,
        clipper:
            _MyClipper(height: height, width: width, top: top, left: left));
  }
}

class _MyClipper extends CustomClipper<Rect> {
  double height;
  double top;
  double width;
  double left;

  _MyClipper({this.height, this.top, this.width, this.left});

  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(left, top, width < 0 ? size.width : width,
        height < 0 ? size.height : height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
