import 'package:flutter/material.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/auth/sign_in_v.dart';

class ProfileViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 4;

  bool _areNotificationsEnabled = true;

  bool get areNotificationsEnabled => _areNotificationsEnabled;

  void toggleNotifications(bool newValue) {
    _areNotificationsEnabled = newValue;
    notifyListeners();
  }

  void logOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void onItemTapped(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PlannerScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GroceriesScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RecipesScreen()),
        );
        break;
      case 4:
        break;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}