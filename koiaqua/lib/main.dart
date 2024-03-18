import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MyApp())

Class MyApp extends StatelessWidget {
  @override
  widget Build(BuildContext contect) {
    return MaterialApp()
    
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}