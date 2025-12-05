import 'package:cloud_firestore/cloud_firestore.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  dessert;

  String get label {
    switch (this) {
      case MealType.breakfast: return 'Breakfast';
      case MealType.lunch: return 'Lunch';
      case MealType.dinner: return 'Dinner';
      case MealType.snack: return 'Snack';
      case MealType.dessert: return 'Dessert';
    }
  }

  static MealType fromString(String label) {
    return MealType.values.firstWhere(
          (e) => e.name == label,
      orElse: () => MealType.breakfast,
    );
  }
}

class Ingredient {
  final String name;
  final String amount;

  Ingredient({required this.name, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] ?? '',
      amount: map['amount'] ?? '',
    );
  }
}

class Recipe {
  final String id;
  final String userId;
  final String title;
  final String imageUrl;
  final int calories;
  final MealType mealType;
  final String description;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.calories,
    required this.mealType,
    required this.description,
    required this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'calories': calories,
      'mealType': mealType.name,
      'description': description,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String docId) {
    final String finalId = docId.isNotEmpty ? docId : (map['id']?.toString() ?? '');

    return Recipe(
      id: docId,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      calories: (map['calories'] is int)
          ? map['calories']
          : int.tryParse(map['calories']?.toString() ?? '0') ?? 0,
      mealType: MealType.fromString(map['mealType'] ?? 'breakfast'),
      description: map['description'] ?? '',
      ingredients: (map['ingredients'] as List<dynamic>? ?? [])
          .map((x) => Ingredient.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }
}