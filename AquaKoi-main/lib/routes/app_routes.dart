import 'package:flutter/material.dart';
import 'package:koiaqua/Presentation/profil_screen.dart';
import '../Presentation/welcome_page.dart';
import '../Presentation/login_screen.dart';
import '../Presentation/register_screen.dart';
import '../Presentation/forget_password_screen.dart';
import '../Presentation/dashboard_screen.dart';
import '../Presentation/edit_profile_screen.dart';
import '../Presentation/app_navigation_screen.dart';

class AppRoutes {

  static const String welcomepage = '/welcome_page';

  static const String loginScreen = '/login_screen';

  static const String registerScreen = '/register_screen';

  static const String dashboardScreen = '/dashboard_screen';

  static const String forgetPasswordScreen = '/forget_password_screen';

  static const String profileScreen = '/profile_screen';
  
  static const String editProfileScreen = '/edit_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    welcomepage: (context) => const WelcomePage(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    dashboardScreen: (context) => DashboardScreen(),
    forgetPasswordScreen: (context) => ForgetPasswordScreen(),
    profileScreen:(context) => ProfileScreen(),
    editProfileScreen: (context) => EditProfileScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen()
  };
}
