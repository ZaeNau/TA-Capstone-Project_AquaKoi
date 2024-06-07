import 'package:flutter/material.dart';
import 'package:aquakoi/Presentation/login_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule navigation after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 650),
            pageBuilder: (_, __, ___) => LoginScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    });

    // Get the screen size for responsive design
    Size screenSize = MediaQuery.of(context).size;

    // Define your percentage-based dimensions
    double topPaddingRatio = 0.23; // For top padding of the logo
    double logoHeightRatio = 0.1; // For the logo size
    double spaceBetweenLogoAndTextRatio = 0.005; // For the space between the logo and text
    double spaceBetweenTextAndSloganRatio = 0.30; // For the space between the text and the slogan

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * topPaddingRatio),
                child: Image.asset(
                  'assets/logo.png',
                  height: screenSize.height * logoHeightRatio,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * spaceBetweenLogoAndTextRatio),
                child: Text(
                  'aquakoi',
                  style: TextStyle(
                    fontSize: screenSize.height * 0.048, // 3.5% of screen height for the font size
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3873F9),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * spaceBetweenTextAndSloganRatio),
                child: Text(
                  'For your better Koi pond companion.',
                  style: TextStyle(
                    fontSize: screenSize.height * 0.021, // 2% of screen height for the font size
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B6B6B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
