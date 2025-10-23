import 'package:flutter/material.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';

class RecipesViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 3;

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
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}