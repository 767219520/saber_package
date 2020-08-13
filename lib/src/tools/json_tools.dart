import 'dart:convert' as convert;

class JsonTool {
  static dynamic toJson(String jsonString) {
    return convert.jsonDecode(jsonString);
  }

  static String toJsonString(dynamic o) {
    if (o == null) return "";
    if (0.runtimeType is String) {
      return o;
    }
    return convert.jsonEncode(o);
  }
}
