import '/models/recipe_model.dart';

class ShoppingListItem {
  final String id;
  final String name;
  final String amount;
  bool isChecked;

  ShoppingListItem({
    required this.id,
    required this.name,
    required this.amount,
    this.isChecked = false,
  });
}

class RecipeGroceryGroup {
  final String recipeTitle;
  final List<Ingredient> ingredients;

  RecipeGroceryGroup({required this.recipeTitle, required this.ingredients});
}

class NewShoppingItem {
  String name;
  String amount;
  NewShoppingItem({this.name = '', this.amount = ''});
}