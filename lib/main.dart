import 'package:flutter/material.dart';
import 'screens/auth/sign_in.dart'; // Import your SignInScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(), // Set SignInScreen as the home screen
      theme: ThemeData(
        primarySwatch: Colors.red, // Optional: Customize the theme
      ),
    );
  }
}