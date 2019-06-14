import 'dart:convert';

class MapUtils {
  static Map<String, dynamic> stringToMap(String jsonString) {
    if (jsonString == null || jsonString.length <= 0) return Map();
    return jsonDecode(jsonString);
  }

  static String mapToString(Object o) {
    return jsonEncode(o);
  }
}
