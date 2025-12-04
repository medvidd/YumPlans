import 'package:flutter/material.dart';
import '/models/recipe_model.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/groceries/groceries_screen.dart';
import '/views/profile/profile_screen.dart';

class RecipesViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 3;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  RecipesViewModel() {
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 2000));

      //throw Exception("Failed to load recipes");

      _recipes = [
        Recipe(
          id: '1',
          title: 'Eggs with tomatoes',
          imageUrl: 'assets/images/eggs_tomatoes.jpg',
          calories: 180,
          mealType: MealType.breakfast,
          description: 'A delicious and healthy breakfast with eggs and fresh tomatoes.',
          ingredients: [
            Ingredient(name: 'Eggs', amount: '2'),
            Ingredient(name: 'Tomatoes', amount: '5'),
            Ingredient(name: 'Bread', amount: '1'),
          ],
        ),
        Recipe(
          id: '2',
          title: 'Pizza rolls',
          imageUrl: 'assets/images/pizza_rolls.jpg',
          calories: 350,
          mealType: MealType.snack,
          description: 'Easy to make pizza rolls perfect for a quick snack.',
          ingredients: [
            Ingredient(name: 'Dough', amount: '200 g'),
            Ingredient(name: 'Cheese', amount: '100 g'),
            Ingredient(name: 'Ham', amount: '50 g'),
          ],
        ),
        Recipe(
          id: '3',
          title: 'Oatmeal with berries',
          imageUrl: 'assets/images/oatmeal.jpg',
          calories: 220,
          mealType: MealType.breakfast,
          description: 'Nutritious oatmeal topped with fresh forest berries.',
          ingredients: [
            Ingredient(name: 'Oats', amount: '50 g'),
            Ingredient(name: 'Milk', amount: '200 ml'),
            Ingredient(name: 'Berries', amount: '50 g'),
          ],
        ),
      ];
    } catch (e) {
      _errorMessage = "Something went wrong. Please try again.";
      _recipes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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