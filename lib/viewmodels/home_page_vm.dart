import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/planner_model.dart';
import '/fb_services/firestore_service.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';

class HomePageViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  int _selectedIndex = 0;
  final String _formattedDate = DateFormat('E, dd/MM').format(DateTime.now());

  int _dailyCalorieGoal = 2000;
  bool _isLoading = false;

  int get dailyCalorieGoal => _dailyCalorieGoal;
  int get selectedIndex => _selectedIndex;
  String get formattedDate => _formattedDate;
  bool get isLoading => _isLoading;

  List<PlannedMeal> _todayMeals = [];
  List<PlannedMeal> get todayMeals => _todayMeals;

  int get consumedCalories => _todayMeals.fold(0, (sum, meal) => sum + meal.recipe.calories);

  HomePageViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _dailyCalorieGoal = prefs.getInt('calorie_goal') ?? 2000;

      await _loadTodayMeals();

    } catch (e) {
      print("Error loading home page data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadTodayMeals() async {
    try {
      final allMeals = await _firestoreService.getPlannedMeals();

      final now = DateTime.now();

      _todayMeals = allMeals.where((meal) {
        return meal.dateTime.year == now.year &&
            meal.dateTime.month == now.month &&
            meal.dateTime.day == now.day;
      }).toList();

      _todayMeals.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    } catch (e) {
      print("Error loading today meals: $e");
      _todayMeals = [];
    }
  }

  Future<void> refreshData() async {
    await _loadData();
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