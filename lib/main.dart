import 'package:flutter/material.dart';
import 'screens/auth/sign_in.dart';
import 'screens/home/home_page.dart';
import 'screens/planner/planner_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: PlannerScreen(),
      home: SignInScreen(), // Set SignInScreen as the home screen
      //home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red, // Optional: Customize the theme
      ),
    );
  }
}