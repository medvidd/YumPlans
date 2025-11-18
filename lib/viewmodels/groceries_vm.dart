import 'package:flutter/material.dart';
import '/views/home_page.dart';
import '/views/planner/planner_screen.dart';
import '/views/recipes/recipes_screen.dart';
import '/views/profile/profile_screen.dart';
import '/models/grocery_model.dart';
import '/models/recipe_model.dart';

class GroceriesViewModel extends ChangeNotifier {
  int selectedIndex = 2;
  bool isEditMode = false;
  bool isShoppingListActive = true;

  bool isAddingNewItem = false;
  NewShoppingItem _newShoppingItem = NewShoppingItem();
  NewShoppingItem get newShoppingItem => _newShoppingItem;

  final List<ShoppingListItem> _shoppingList = [
    ShoppingListItem(id: 's1', name: 'Eggs', amount: '10', isChecked: true),
    ShoppingListItem(id: 's2', name: 'Cheese', amount: '300 g', isChecked: false),
    ShoppingListItem(id: 's3', name: 'Tomatoes', amount: '5', isChecked: true),
    ShoppingListItem(id: 's4', name: 'Bread', amount: '1', isChecked: false),
  ];
  List<ShoppingListItem> get shoppingList => _shoppingList;

  final List<RecipeGroceryGroup> _groceriesByRecipe = [
    RecipeGroceryGroup(
      recipeTitle: 'Eggs and tomatoes',
      ingredients: [
        Ingredient(name: 'Tomatoes', amount: '5'),
        Ingredient(name: 'Eggs', amount: '2'),
      ],
    ),
    RecipeGroceryGroup(
      recipeTitle: 'Pizza rolls',
      ingredients: [
        Ingredient(name: 'Tomatoes', amount: '5'),
        Ingredient(name: 'Eggs', amount: '2'),
        Ingredient(name: 'Cheese', amount: '300 g'),
      ],
    ),
    RecipeGroceryGroup(
      recipeTitle: 'Cinnamon',
      ingredients: [
        Ingredient(name: 'Eggs', amount: '2'),
        Ingredient(name: 'Cheese', amount: '300 g'),
      ],
    ),
  ];
  List<RecipeGroceryGroup> get groceriesByRecipe => _groceriesByRecipe;

  int get itemsToBuyCount => _shoppingList.where((item) => !item.isChecked).length;

  void toggleCheckedState(String id) {
    final item = _shoppingList.firstWhere((i) => i.id == id);
    item.isChecked = !item.isChecked;
    notifyListeners();
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

  void saveNewItem() {
    if (_newShoppingItem.name.isNotEmpty && _newShoppingItem.amount.isNotEmpty) {

      addShoppingItem(_newShoppingItem.name, _newShoppingItem.amount);
      isAddingNewItem = false;
      _newShoppingItem = NewShoppingItem();

    } else {

      isAddingNewItem = false;
      notifyListeners();
    }
  }

  void addShoppingItem(String name, String amount) {

    final newId = DateTime.now().microsecondsSinceEpoch.toString();
    _shoppingList.add(ShoppingListItem(id: newId, name: name, amount: amount));
    notifyListeners();
  }

  void removeShoppingItem(String id) {
    _shoppingList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addIngredientToShoppingList(Ingredient ingredient) {
    addShoppingItem(ingredient.name, ingredient.amount);
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