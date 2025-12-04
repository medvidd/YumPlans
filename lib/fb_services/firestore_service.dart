import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/recipe_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Отримати колекцію рецептів
  CollectionReference get _recipesCollection => _db.collection('recipes');

  // Отримати поточного юзера
  String? get currentUserId => _auth.currentUser?.uid;

  // --- CREATE ---
  Future<void> addRecipe(Recipe recipe) async {
    if (currentUserId == null) throw Exception("User not logged in");

    // Використовуємо .doc(recipe.id).set(...) щоб зберегти згенерований нами ID,
    // або .add(...) щоб Firestore сам згенерував ID.
    // Оскільки ми генеруємо UUID у ViewModel, використаємо set.
    await _recipesCollection.doc(recipe.id).set(recipe.toMap());
  }

  // --- READ ---
  // Отримати рецепти тільки поточного користувача
  Future<List<Recipe>> getUserRecipes() async {
    if (currentUserId == null) return [];

    try {
      QuerySnapshot snapshot = await _recipesCollection
          .where('userId', isEqualTo: currentUserId)
      //.orderBy('createdAt', descending: true) // Потрібен індекс у Firestore, поки можна без цього
          .get();

      return snapshot.docs.map((doc) {
        return Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching recipes: $e");
      rethrow;
    }
  }

  // --- UPDATE ---
  Future<void> updateRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).update(recipe.toMap());
  }

  // --- DELETE ---
  Future<void> deleteRecipe(String recipeId) async {
    await _recipesCollection.doc(recipeId).delete();
  }
}