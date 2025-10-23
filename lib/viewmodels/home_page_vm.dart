import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';

class HomePageViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  String _formattedDate = DateFormat('E, dd/MM').format(DateTime.now());

  int get selectedIndex => _selectedIndex;
  String get formattedDate => _formattedDate;

  void onItemTapped(BuildContext context, int index) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}