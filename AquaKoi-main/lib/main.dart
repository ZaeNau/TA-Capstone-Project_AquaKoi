import 'package:flutter/material.dart';
import 'Presentation/welcome_page.dart';
void main() {
  runApp(AquaKoi());
}

class AquaKoi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Google Sans',
      ),
      home: WelcomePage(),
    );
  }
}