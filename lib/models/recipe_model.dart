enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  dessert;

  String get label {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
      case MealType.dessert:
        return 'Dessert';
    }
  }
}

class Ingredient {
  final String name;
  final String amount;

  Ingredient({required this.name, required this.amount});
}

class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final int calories;
  final MealType mealType;
  final String description;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.calories,
    required this.mealType,
    required this.description,
    required this.ingredients,
  });
}