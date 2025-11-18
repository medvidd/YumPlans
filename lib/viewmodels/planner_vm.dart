import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/views/home_page.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';
import '/models/planner_model.dart';
import '/models/recipe_model.dart';

class PlannerViewModel extends ChangeNotifier {
  int selectedIndex = 1;

  late DateTime _today;
  DateTime get today => _today;

  late DateTime currentDate;
  bool showCalendar = false;
  late DateTime focusedMonth;

  final DateFormat monthFormat = DateFormat('MMMM yyyy');
  final DateFormat weekFormat = DateFormat('MMMM d');
  final DateFormat dayFormat = DateFormat('E');
  final DateFormat dateNumberFormat = DateFormat('d');
  final DateFormat timeFormat = DateFormat('HH:mm');

  List<PlannedMeal> _allPlannedMeals = [];

  List<PlannedMeal> get mealsForSelectedDay {
    return _allPlannedMeals.where((meal) {
      return meal.dateTime.year == currentDate.year &&
          meal.dateTime.month == currentDate.month &&
          meal.dateTime.day == currentDate.day;
    }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  PlannerViewModel() {
    _today = DateTime.now().toUtc().add(const Duration(hours: 3));
    currentDate = _today;
    focusedMonth = DateTime(_today.year, _today.month, 1);
    _loadDummyData();
  }

  void _loadDummyData() {
    final dummyRecipe = Recipe(
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

    _allPlannedMeals = [
      PlannedMeal(
        id: '1',
        dateTime: DateTime(today.year, today.month, today.day, 8, 30),
        recipe: dummyRecipe,
        mealType: 'Breakfast',
      ),
      PlannedMeal(
        id: '2',
        dateTime: DateTime(today.year, today.month, today.day, 12, 0),
        recipe: dummyRecipe2,
        mealType: 'Snack',
      ),
    ];
    notifyListeners();
  }

  void updateTodayIfNeeded() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 3));
    if (now.year != _today.year || now.month != _today.month || now.day != _today.day) {
      _today = now;
      notifyListeners();
      print("Date updated to a new day!");
    }
  }

  void toggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void navigateWeek(bool forward) {
    currentDate = currentDate.add(Duration(days: forward ? 7 : -7));
    notifyListeners();
  }

  void navigateMonth(bool forward) {
    focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + (forward ? 1 : -1), 1);
    notifyListeners();
  }

  List<DateTime> getWeekDates() {
    int weekday = currentDate.weekday % 7;
    final startOfWeek = currentDate.subtract(Duration(days: weekday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void selectDate(DateTime date) {
    currentDate = date;
    focusedMonth = DateTime(date.year, date.month, 1);
    showCalendar = false;
    notifyListeners();
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

  List<DateTime?> getDaysInMonth() {
    final firstDayOfMonth = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final lastDayOfMonth = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);
    final days = <DateTime?>[];

    for (int i = 0; i < firstDayOfMonth.weekday % 7; i++) {
      days.add(null);
    }

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(focusedMonth.year, focusedMonth.month, i));
    }

    return days;
  }
}