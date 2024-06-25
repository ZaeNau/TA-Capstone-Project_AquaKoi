import 'package:aquakoi/main.dart';
import 'package:aquakoi/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initNotifications() async {
    User? user = _auth.currentUser;
    if (user == null) {
      _auth.authStateChanges().listen((User? user) async {
        if (user != null) {
          await _initializeFCMToken(user.uid);
        }
      });
    } else {
      await _initializeFCMToken(user.uid);
    }
  }

  Future<void> _initializeFCMToken(String userId) async {
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
