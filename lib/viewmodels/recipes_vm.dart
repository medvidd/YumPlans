import 'package:flutter/material.dart';
import '/models/recipe_model.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../fb_services/firestore_service.dart';
import '../fb_services/upload_service.dart';

class RecipesViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final UploadService _uploadService = UploadService();
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 3;
  bool _isLoading = false;
  String? _errorMessage;
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Recipe> get recipes => searchController.text.isEmpty ? _recipes : _filteredRecipes;

  RecipesViewModel() {
    fetchRecipes();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> fetchRecipes() async {
    _setLoading(true);
    try {
      _recipes = await _firestoreService.getUserRecipes();

      if (searchController.text.isNotEmpty) {
        _onSearchChanged();
      }

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load recipes. Please try again.";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addRecipe({
    required String title,
    required String imageUrl,
    required int calories,
    required MealType mealType,
    required String description,
    required List<Ingredient> ingredients,
  }) async {
    _setLoading(true);
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isEmpty) throw Exception('User not logged in');

      final newRecipe = Recipe(
        id: const Uuid().v4(), // Генеруємо унікальний ID
        userId: userId,
        title: title,
        imageUrl: imageUrl,
        calories: calories,
        mealType: mealType,
        description: description,
        ingredients: ingredients,
      );

      await _firestoreService.addRecipe(newRecipe);
      await fetchRecipes(); // Оновлюємо список
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateRecipe(Recipe updatedRecipe) async {
    _setLoading(true);
    try {
      await _firestoreService.updateRecipe(updatedRecipe);
      await fetchRecipes();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    _setLoading(true);
    try {
      // 1. Знаходимо рецепт, щоб отримати посилання на фото
      final recipeToDelete = _recipes.firstWhere(
              (r) => r.id == recipeId,
          orElse: () => _recipes[0] // Заглушка, якщо раптом не знайдено (малоймовірно)
      );

      // 2. Якщо у рецепта є фото (і це не заглушка), видаляємо його з хмари
      if (recipeToDelete.imageUrl.isNotEmpty) {
        await _uploadService.deleteFile(recipeToDelete.imageUrl);
      }

      // 3. Видаляємо запис з Firestore
      await _firestoreService.deleteRecipe(recipeId);

      // 4. Оновлюємо список
      await fetchRecipes();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> uploadImage() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    return await _uploadService.pickAndUploadImage(userId: userId, folder: 'recipes');
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      _filteredRecipes = [];
    } else {
      _filteredRecipes = _recipes.where((recipe) {
        final titleMatch = recipe.title.toLowerCase().contains(query);
        final ingredientMatch = recipe.ingredients.any((i) => i.name.toLowerCase().contains(query));
        final tagMatch = recipe.mealType.label.toLowerCase().contains(query);

        return titleMatch || ingredientMatch || tagMatch;
      }).toList();
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;
    selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PlannerScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GroceriesScreen()));
        break;
      case 3:
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
        break;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}