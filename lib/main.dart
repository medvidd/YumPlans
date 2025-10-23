import 'package:flutter/material.dart';
import 'views/auth/sign_in_v.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Kantumruy Pro',
      ),
    );
  }
}