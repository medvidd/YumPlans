import 'package:flutter/material.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/profile/profile_screen.dart';

class GroceriesViewModel extends ChangeNotifier {
  int selectedIndex = 2;

  bool isShoppingListActive = true;

  void selectShoppingList() {
    if (!isShoppingListActive) {
      isShoppingListActive = true;
      notifyListeners();
    }
  }

  void selectGroceries() {
    if (isShoppingListActive) {
      isShoppingListActive = false;
      notifyListeners();
    }
  }

  void onItemTapped(BuildContext context, int index) {
    if (selectedIndex == index) return;
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
      // Вже на цьому екрані
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