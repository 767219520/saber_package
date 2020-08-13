import 'dart:convert' as convert;

class JsonTool {
  static dynamic toJson(String jsonString) {
    return convert.jsonDecode(jsonString);
  }

   static String toJsonString(dynamic o) {
    return convert.jsonEncode(o);
  }
}
