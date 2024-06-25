import 'package:aquakoi/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import '../routes/app_routes.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications(String userId) async {
    try {
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();
      print('Token: $fCMToken');
      if (fCMToken != null) {
        final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
        await databaseRef.child('UsersData/$userId/fcmToken').set(fCMToken);
      } else {
        print('FCM Token is null.');
      }
    } catch (e) {
      print('Error initializing notifications: $e');
      // Handle error and inform user about notification permission
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      navigatorKey.currentState?.pushNamed(AppRoutes.dashboardScreen);
    }
  }

  Future<void> initPushNotifications() async {
    try {
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    } catch (e) {
      print('Error initializing push notifications: $e');
    }
  }
}
