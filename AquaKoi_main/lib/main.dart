import 'package:aquakoi/firebase/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Contoh penggunaan initNotifications dengan userId
  String userId = 'cSFGHidGb4gzLBalujMaowdFDGG2'; // Ganti dengan userId yang sesuai
  await FirebaseApi().initNotifications(userId); // Memperbaiki pemanggilan initNotifications

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: theme,
          title: 'aquakoi',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.welcomepage,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
