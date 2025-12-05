import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/recipe_model.dart';

class PlannedMeal {
  final String id;
  final String userId;
  final DateTime dateTime;
  final Recipe recipe;
  final String mealType;

  PlannedMeal({
    required this.id,
    required this.userId,
    required this.dateTime,
    required this.recipe,
    required this.mealType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'dateTime': Timestamp.fromDate(dateTime),
      'recipe': recipe.toMap(),
      'mealType': mealType,
    };
  }

  factory PlannedMeal.fromMap(Map<String, dynamic> map) {
    DateTime date;
    try {
      date = (map['dateTime'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }

    final recipeMap = map['recipe'] as Map<String, dynamic>? ?? {};

    return PlannedMeal(
      id: map['id']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      dateTime: date,
      recipe: Recipe.fromMap(recipeMap, ''),
      mealType: map['mealType']?.toString() ?? '',
    );
  }
}