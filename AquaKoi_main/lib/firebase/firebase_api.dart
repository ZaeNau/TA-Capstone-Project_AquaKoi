import 'package:aquakoi/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../routes/app_routes.dart';

class FirebaseApi {
  // Firebase messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotifications() async {
    // Request permission from user
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();
    // Token check
    print('Token: $fCMToken');
  }

  // Function to handle receiving messages
  void handleMessage(RemoteMessage? message) {
    // If message is null, do nothing
    if (message == null) return;

    // Navigate to new screen when user taps the notification
    navigatorKey.currentState?.pushNamed(AppRoutes.dashboardScreen);
  }

  // Function to initialize background settings
  Future<void> initPushNotifications() async {
    // Handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
