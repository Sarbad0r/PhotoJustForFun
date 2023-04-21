// ignore_for_file: non_constant_identifier_names

import 'package:photo_just_for_fun/utils/shared_preferences.dart';

class ApiConnections {
  static String BACKEND_URL = "http://192.168.100.113:8000/api";

  static String PHOTO_PIXELS_URL = 'https://api.pexels.com';

  static Map<String, String> photo_pixel_headers() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization':
          'xbzGzuMrIvb5WTcVeeQvBx2BNE04zfS4NhFJXsFQv7InLOAMEmHSueBR'
    };
  }

  static Future<Map<String, String>> backend_headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await SharedPref.getStringPrefer('token')}'
    };
  }
}
