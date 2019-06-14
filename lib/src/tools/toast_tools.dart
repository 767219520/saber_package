import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
class ToastTools{
  static Color _color= Color(0xffFFFFFF);
  static showShort(String msg,[Color color=null]) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xff63CA6C),
        textColor: color==null?_color:color);
  }
}