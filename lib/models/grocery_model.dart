import '/models/recipe_model.dart';

class ShoppingListItem {
  final String id;
  final String userId;
  final String name;
  final String amount;
  bool isChecked;

  ShoppingListItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.amount,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'amount': amount,
      'isChecked': isChecked,
    };
  }

  // Створення з Firestore
  factory ShoppingListItem.fromMap(Map<String, dynamic> map) {
    return ShoppingListItem(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      amount: map['amount'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }

  // Метод для створення копії зі зміненими полями (для оновлення кількості)
  ShoppingListItem copyWith({
    String? id,
    String? userId,
    String? name,
    String? amount,
    bool? isChecked,
  }) {
    return ShoppingListItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      isChecked: isChecked ?? this.isChecked,
    );
  }
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