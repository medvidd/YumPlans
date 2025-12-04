import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../fb_services/auth_service.dart';
import '../views/home_page.dart';
import '../views/planner/planner_screen.dart';
import '../views/groceries/groceries_screen.dart';
import '../views/recipes/recipes_screen.dart';
import '../views/auth/sign_in_v.dart';
import '../fb_services/upload_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UploadService _uploadService = UploadService();

  // --- Існуючі поля ---
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 4;
  bool _areNotificationsEnabled = true;
  int _calorieGoal = 2000;

  // --- Нові поля ---
  User? _currentUser;
  bool _isLoading = false;

  // Геттери
  bool get areNotificationsEnabled => _areNotificationsEnabled;
  int get calorieGoal => _calorieGoal;
  bool get isLoading => _isLoading;
  User? get currentUser => _currentUser;
  String get userName => _currentUser?.displayName ?? "No Name";
  String get userEmail => _currentUser?.email ?? "No Email";
  String? get photoUrl => _currentUser?.photoURL;

  ProfileViewModel() {
    _getCurrentUser();
    _loadSettings();
  }

  void _getCurrentUser() {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  // --- ЛОГІКА ЗАВАНТАЖЕННЯ ЗОБРАЖЕННЯ (SUPABASE) ---
  Future<String?> pickImage(BuildContext context) async {
    if (_currentUser == null) return null;

    _setLoading(true);
    String? downloadedUrl;

    try {
      // Завантажуємо фото в Supabase
      downloadedUrl = await _uploadService.pickAndUploadImage(_currentUser!.uid);

      // Якщо Url отримано, це успіх, але ми ще не зберігаємо його в Firebase,
      // це станеться коли юзер натисне "Save"
    } catch (e) {
      if (context.mounted) _showError(context, "Upload failed: $e");
    }

    _setLoading(false);
    return downloadedUrl;
  }

  // --- ОБ'ЄДНАНИЙ МЕТОД ЗБЕРЕЖЕННЯ ПРОФІЛЮ ---
  Future<void> updateUserProfile(BuildContext context, {required String newName, required String newPhotoUrl}) async {
    _setLoading(true); // Вмикаємо спіннер на кнопці

    try {
      bool hasChanges = false;

      // 1. Оновлюємо ім'я, якщо воно змінилося
      if (newName != userName && newName.isNotEmpty) {
        await _authService.updateDisplayName(newName);
        hasChanges = true;
      }

      // 2. Оновлюємо фото, якщо посилання змінилося
      if (newPhotoUrl != (photoUrl ?? '') && newPhotoUrl.isNotEmpty) {
        await _authService.updatePhotoURL(newPhotoUrl);
        hasChanges = true;
      }

      // 3. Оновлюємо локальні дані
      _getCurrentUser();

      if (context.mounted) {
        // Закриваємо модальне вікно ТІЛЬКИ тут, після всіх операцій
        Navigator.of(context).pop();

        if (hasChanges) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) _showError(context, "Update failed: $e");
    }

    _setLoading(false); // Вимикаємо спіннер
  }

  // Зміна паролю
  Future<void> updatePassword(BuildContext context, String newPass) async {
    if (newPass.length < 6) {
      _showError(context, 'Password must be at least 6 characters');
      return;
    }
    _setLoading(true);

    try {
      await _authService.updatePassword(newPass);
      if (context.mounted) {
        Navigator.pop(context); // Закриваємо діалог паролю
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed successfully!')));
      }
    } catch (e) {
      if (context.mounted) _showError(context, 'Error: $e. Try logging in again.');
    }

    _setLoading(false);
  }

  // Зміна пошти
  Future<void> updateEmail(BuildContext context, String newEmail) async {
    if (newEmail.isEmpty) return;
    _setLoading(true);

    try {
      await _authService.updateEmail(newEmail);
      if (context.mounted) {
        Navigator.pop(context); // Закриваємо діалог пошти
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verification email sent!')));
      }
    } catch (e) {
      if (context.mounted) _showError(context, e.toString());
    }

    _setLoading(false);
  }

  // Допоміжні методи
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  // --- ВАША ІСНУЮЧА ЛОГІКА (БЕЗ ЗМІН) ---
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _calorieGoal = prefs.getInt('calorie_goal') ?? 2000;
    notifyListeners();
  }

  Future<void> updateCalorieGoal(String newGoalStr) async {
    int? newGoal = int.tryParse(newGoalStr);
    if (newGoal != null && newGoal > 0) {
      _calorieGoal = newGoal;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('calorie_goal', _calorieGoal);
      notifyListeners();
    }
  }

  void toggleNotifications(bool newValue) {
    _areNotificationsEnabled = newValue;
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    await _authService.signOut();
    await FirebaseAnalytics.instance.logEvent(name: 'logout');

    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;
    selectedIndex = index;
    notifyListeners();

    Widget nextScreen;
    switch (index) {
      case 0: nextScreen = const HomePageScreen(); break;
      case 1: nextScreen = const PlannerScreen(); break;
      case 2: nextScreen = const GroceriesScreen(); break;
      case 3: nextScreen = const RecipesScreen(); break;
      case 4: return;
      default: return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
}