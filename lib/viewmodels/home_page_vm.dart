import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/planner_model.dart';
import '/models/recipe_model.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';

class HomePageViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  final String _formattedDate = DateFormat('E, dd/MM').format(DateTime.now());

  final int dailyCalorieGoal = 2000;

  int get selectedIndex => _selectedIndex;
  String get formattedDate => _formattedDate;

  List<PlannedMeal> _todayMeals = [];
  List<PlannedMeal> get todayMeals => _todayMeals;

  int get consumedCalories => _todayMeals.fold(0, (sum, meal) => sum + meal.recipe.calories);

  HomePageViewModel() {
    _loadTodayMeals();
  }

  void _loadTodayMeals() {
    final today = DateTime.now();

    final dummyRecipe1 = Recipe(
      id: '1',
      title: 'Eggs with tomatoes',
      imageUrl: 'assets/images/eggs_tomatoes.jpg',
      calories: 180,
      mealType: MealType.breakfast,
      description: 'Test',
      ingredients: [],
    );

    final dummyRecipe2 = Recipe(
      id: '2',
      title: 'Pizza rolls',
      imageUrl: 'assets/images/pizza_rolls.jpg',
      calories: 350,
      mealType: MealType.snack,
      description: 'Test',
      ingredients: [],
    );

    _todayMeals = [
      PlannedMeal(
        id: '1',
        dateTime: DateTime(today.year, today.month, today.day, 8, 30),
        recipe: dummyRecipe1,
        mealType: 'Breakfast',
      ),
      PlannedMeal(
        id: '2',
        dateTime: DateTime(today.year, today.month, today.day, 12, 0),
        recipe: dummyRecipe2,
        mealType: 'Snack',
      ),
    ];

    _todayMeals.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    notifyListeners();
  }

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