import 'package:aquakoi/main.dart';
import 'package:aquakoi/routes/app_routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications(String userId) async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    if (fCMToken != null) {
      final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('UsersData/$userId/fcmToken').set(fCMToken);
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(AppRoutes.dashboardScreen);
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
