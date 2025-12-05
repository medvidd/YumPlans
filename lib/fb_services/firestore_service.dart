import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/recipe_model.dart';
import '/models/grocery_model.dart';
import '/models/planner_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _recipesCollection => _db.collection('recipes');
  CollectionReference get _shoppingCollection => _db.collection('shopping_items');
  CollectionReference get _plannedMealsCollection => _db.collection('planned_meals');

  String? get currentUserId => _auth.currentUser?.uid;

  //recipes

  Future<void> addRecipe(Recipe recipe) async {
    if (currentUserId == null) throw Exception("User not logged in");
  await _recipesCollection.doc(recipe.id).set(recipe.toMap());
  }

  Future<List<Recipe>> getUserRecipes() async {
    if (currentUserId == null) return [];

    try {
      QuerySnapshot snapshot = await _recipesCollection
          .where('userId', isEqualTo: currentUserId)
          .get();

      return snapshot.docs.map((doc) {
        return Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching recipes: $e");
      rethrow;
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).update(recipe.toMap());
  }

  Future<void> deleteRecipe(String recipeId) async {
    await _recipesCollection.doc(recipeId).delete();
  }

  //groceries

  Future<List<ShoppingListItem>> getShoppingList() async {
    if (currentUserId == null) return [];
    try {
      QuerySnapshot snapshot = await _shoppingCollection
          .where('userId', isEqualTo: currentUserId)
          .get();

      return snapshot.docs.map((doc) {
        return ShoppingListItem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching shopping list: $e");
      rethrow;
    }
  }

  Future<void> addShoppingItem(ShoppingListItem item) async {
    if (currentUserId == null) return;
    await _shoppingCollection.doc(item.id).set(item.toMap());
  }

  Future<void> updateShoppingItem(ShoppingListItem item) async {
    await _shoppingCollection.doc(item.id).update(item.toMap());
  }

  Future<void> deleteShoppingItem(String itemId) async {
    await _shoppingCollection.doc(itemId).delete();
  }

  //planner

  Future<List<PlannedMeal>> getPlannedMeals() async {
    if (currentUserId == null) return [];
    try {
      QuerySnapshot snapshot = await _plannedMealsCollection
          .where('userId', isEqualTo: currentUserId)
          .get();

      return snapshot.docs.map((doc) {
        return PlannedMeal.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching planned meals: $e");
      rethrow;
    }
  }

  Future<void> addPlannedMeal(PlannedMeal meal) async {
    if (currentUserId == null) return;
    await _plannedMealsCollection.doc(meal.id).set(meal.toMap());
  }

  Future<void> deletePlannedMeal(String id) async {
    await _plannedMealsCollection.doc(id).delete();
  }

  Future<void> updatePlannedMeal(PlannedMeal meal) async {
    if (currentUserId == null) return;
    await _plannedMealsCollection.doc(meal.id).update(meal.toMap());
  }

}