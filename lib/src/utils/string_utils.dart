import 'package:common_utils/common_utils.dart';

class StringUtils {
  static String blank([int length = 1]) {
    String b = "";
    for (var i = 0; i < length; i++) {
      b += " ";
    }
    return b;
  }

  static bool isEmpty(String str) {
    return str == null || str.length <= 0;
  }

  static bool isNotEmpty(String str) {
    return !isEmpty(str);
  }

  static String sensitiveConceal(String value, int s, int l) {
    if (isEmpty(value)) return "";
    String sensitive = repeatString("*", l, "");
    return substring(value, 0, s) + sensitive + value.substring(s + l);
  }

  static String repeatString(String str, int n, String seg) {
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < n; i++) {
      sb.write(str);
      sb.write(seg);
    }
    return sb.toString().substring(0, sb.length - seg.length);
  }

  static String substring(String str, int start, int end) {
    if (str == null) return null;
    if (end < 0) end = str.length + end;
    if (start < 0) start = str.length + start;
    if (end > str.length) end = str.length;
    if (start > end) return "";
    if (start < 0) start = 0;
    if (end < 0) end = 0;
    return str.substring(start, end);
  }



  
}
