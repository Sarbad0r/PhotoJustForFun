import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:photo_just_for_fun/api/utils/shared_preferences.dart';

class FirebaseNotification {
  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    } else {
      print("user has not accepted permission");
    }
  }

  static Future<void> getToken() async {
    String token = await SharedPref.getStringPrefer('firebase_token');
    print("before token : $token");
    if (token.isNotEmpty) return;
    await FirebaseMessaging.instance.getToken().then((value) async {
      print("firebase_token $value");
      SharedPref.saveStringPrefer(
          keyName: 'firebase_token', value: value ?? '');
    });
  }

  // static Future<void> saveToken()
}
