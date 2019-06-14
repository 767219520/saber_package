import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String value;
  final double fontSize;
  final Color color;

  TextWidget({this.value, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: fontSize, color: color);
    return Text(value, style: textStyle);
  }
}
