import 'dart:convert';

class JsonUtil {
  static dynamic _myEncoder(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  static String encode(Map<String, dynamic> json,
      {Object? Function(Object? nonEncodable)? toEncodable}) {
    return jsonEncode(json, toEncodable: toEncodable ?? _myEncoder);
  }

  static Map<String, dynamic> decode(String jsonString) {
    return jsonDecode(jsonString);
  }
}
