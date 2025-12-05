import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/fb_services/firestore_service.dart';
import '/views/home_page.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';
import '/models/planner_model.dart';
import '/models/recipe_model.dart';

class PlannerViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  int selectedIndex = 1;
  late DateTime _today;
  DateTime get today => _today;

  late DateTime currentDate;
  bool showCalendar = false;
  late DateTime focusedMonth;
  bool _isLoading = false;
  String? _errorMessage; // Додано поле помилки

  final DateFormat monthFormat = DateFormat('MMMM yyyy');
  final DateFormat weekFormat = DateFormat('MMMM d');
  final DateFormat dayFormat = DateFormat('E');
  final DateFormat dateNumberFormat = DateFormat('d');

  List<PlannedMeal> _allPlannedMeals = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<PlannedMeal> get mealsForSelectedDay {
    return _allPlannedMeals.where((meal) {
      return meal.dateTime.year == currentDate.year &&
          meal.dateTime.month == currentDate.month &&
          meal.dateTime.day == currentDate.day;
    }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  PlannerViewModel() {
    _today = DateTime.now();
    currentDate = _today;
    focusedMonth = DateTime(_today.year, _today.month, 1);
    fetchPlannedMeals();
  }

  // --- FIRESTORE ---

  Future<void> fetchPlannedMeals() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      print("Fetching meals..."); // DEBUG LOG
      _allPlannedMeals = await _firestoreService.getPlannedMeals();
      print("Fetched ${_allPlannedMeals.length} meals"); // DEBUG LOG
    } catch (e) {
      print("ERROR fetching planner: $e"); // DEBUG LOG
      _errorMessage = "Could not load meals: $e";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addPlannedMeal({
    required DateTime dateTime,
    required Recipe recipe,
    String? mealType,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      _errorMessage = "User not logged in";
      notifyListeners();
      return;
    }

    _setLoading(true);
    try {
      final newMeal = PlannedMeal(
        id: const Uuid().v4(),
        userId: userId,
        dateTime: dateTime,
        recipe: recipe,
        mealType: mealType ?? recipe.mealType.label,
      );

      print("Adding meal for: $dateTime"); // DEBUG LOG
      await _firestoreService.addPlannedMeal(newMeal);
      await fetchPlannedMeals();
    } catch (e) {
      print("ERROR adding meal: $e"); // DEBUG LOG
      _errorMessage = "Failed to add meal";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updatePlannedMeal(PlannedMeal meal) async {
    _setLoading(true);
    try {
      await _firestoreService.updatePlannedMeal(meal);
      await fetchPlannedMeals();
    } catch (e) {
      print("ERROR updating meal: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deletePlannedMeal(String id) async {
    _setLoading(true);
    try {
      await _firestoreService.deletePlannedMeal(id);
      await fetchPlannedMeals();
    } catch (e) {
      print("ERROR deleting meal: $e");
    } finally {
      _setLoading(false);
    }
  }

  // --- CALENDAR LOGIC ---

  void updateTodayIfNeeded() {
    final now = DateTime.now();
    if (now.year != _today.year || now.month != _today.month || now.day != _today.day) {
      _today = now;
      notifyListeners();
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

  void _setLoading(bool value) {
    _isLoading = value;
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
}