import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var package;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(Home as String package))
    ); //scaffold
  }
}

class Home {
}