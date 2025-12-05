import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/fb_services/firestore_service.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/profile/profile_screen.dart';
import '/models/grocery_model.dart';
import '/models/recipe_model.dart';


class GroceriesViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  int selectedIndex = 2;
  bool isEditMode = false;
  bool isShoppingListActive = true;
  bool _isLoading = false;

  bool isAddingNewItem = false;
  NewShoppingItem _newShoppingItem = NewShoppingItem();

  List<ShoppingListItem> _shoppingList = [];
  List<RecipeGroceryGroup> _groceriesByRecipe = [];

  bool get isLoading => _isLoading;
  NewShoppingItem get newShoppingItem => _newShoppingItem;
  List<RecipeGroceryGroup> get groceriesByRecipe => _groceriesByRecipe;

  List<ShoppingListItem> get shoppingList {
    _shoppingList.sort((a, b) {
      if (a.isChecked && !b.isChecked) return 1;
      if (!a.isChecked && b.isChecked) return -1;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return _shoppingList;
  }

  int get itemsToBuyCount => _shoppingList.where((item) => !item.isChecked).length;

  GroceriesViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    _setLoading(true);
    try {
      _shoppingList = await _firestoreService.getShoppingList();

      final recipes = await _firestoreService.getUserRecipes();

      _groceriesByRecipe = recipes.map((recipe) {
        return RecipeGroceryGroup(
          recipeTitle: recipe.title,
          ingredients: recipe.ingredients,
        );
      }).toList();

    } catch (e) {
      print("Error loading groceries: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleCheckedState(String id) async {
    final index = _shoppingList.indexWhere((i) => i.id == id);
    if (index != -1) {
      final item = _shoppingList[index];
      item.isChecked = !item.isChecked;
      notifyListeners();

      await _firestoreService.updateShoppingItem(item);
    }
  }

  Future<void> saveNewItem() async {
    if (_newShoppingItem.name.isNotEmpty) {
      await addShoppingItem(_newShoppingItem.name, _newShoppingItem.amount);

      isAddingNewItem = false;
      _newShoppingItem = NewShoppingItem();
      notifyListeners(); // Оновлюємо UI
    } else {
      // Якщо пусте ім'я - просто закриваємо
      isAddingNewItem = false;
      notifyListeners();
    }
  }

  Future<void> addShoppingItem(String name, String amount) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final cleanName = name.trim();
    final cleanAmount = amount.trim();

    // Створюємо новий елемент завжди
    final newItem = ShoppingListItem(
      id: const Uuid().v4(),
      userId: userId,
      name: cleanName,
      amount: cleanAmount,
      isChecked: false,
    );

    _shoppingList.add(newItem);
    notifyListeners();
    await _firestoreService.addShoppingItem(newItem);
  }

  Future<void> removeShoppingItem(String id) async {
    _shoppingList.removeWhere((item) => item.id == id);
    notifyListeners();
    await _firestoreService.deleteShoppingItem(id);
  }

  Future<void> addIngredientToShoppingList(BuildContext context, Ingredient ingredient) async {
    await addShoppingItem(ingredient.name, ingredient.amount);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${ingredient.name} added to list!'),
          duration: const Duration(milliseconds: 700),
          backgroundColor: const Color(0xFFABBA72),
        ),
      );
    }
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  void startAddingNewItem() {
    isAddingNewItem = true;
    _newShoppingItem = NewShoppingItem();
    notifyListeners();
  }

  void cancelAddingNewItem() {
    isAddingNewItem = false;
    _newShoppingItem = NewShoppingItem();
    notifyListeners();
  }

  void updateNewItemName(String name) {
    _newShoppingItem.name = name;
  }

  void updateNewItemAmount(String amount) {
    _newShoppingItem.amount = amount;
  }

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

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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