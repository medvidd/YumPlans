import '/models/recipe_model.dart';

class PlannedMeal {
  final String id;
  final DateTime dateTime;
  final Recipe recipe;
  final String mealType;

  PlannedMeal({
    required this.id,
    required this.dateTime,
    required this.recipe,
    required this.mealType,
  });
}