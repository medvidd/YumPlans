import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/models/recipe_model.dart';
import '/viewmodels/recipes_vm.dart';
import 'create_recipe_screen.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe; // Це початковий об'єкт (для отримання ID)

  const RecipeDetailsScreen({super.key, required this.recipe});

  void _confirmDelete(BuildContext context, RecipesViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        title: const Text('Delete Recipe?', style: TextStyle(color: Color(0xFF4B572B))),
        content: const Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF708240))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); // Закрити діалог

              // Викликаємо видалення
              await vm.deleteRecipe(recipe.id);

              // Якщо екран ще активний, повертаємось назад до списку
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFF991800))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    final double imageSize = isTablet ? 350 : 255;
    final double titleFontSize = isTablet ? 32 : 24;
    final double subtitleFontSize = isTablet ? 20 : 16;
    final double sectionTitleFontSize = isTablet ? 22 : 18;
    final double bodyFontSize = isTablet ? 18 : 14;

    final double horizontalPadding = isTablet ? 80.0 : 24.0;
    final double bgWidth = screenWidth * (isTablet ? 1.3 : 1.2);
    final double bgHeight = isTablet ? 500 : 412;
    final double bgLeft = (screenWidth - bgWidth) / 2;
    final double bgTop = isTablet ? -250 : -200;

    // ВИКОРИСТОВУЄМО CONSUMER ДЛЯ СЛУХАННЯ ЗМІН
    return Consumer<RecipesViewModel>(
      builder: (context, vm, child) {
        // Якщо йде завантаження (наприклад, видалення), показуємо спіннер
        if (vm.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFFFFBF0),
            body: Center(child: CircularProgressIndicator(color: Color(0xFFABBA72))),
          );
        }

        // ШУКАЄМО АКТУАЛЬНУ ВЕРСІЮ РЕЦЕПТУ У СПИСКУ VM
        // Це критично для того, щоб побачити зміни після редагування.
        Recipe currentRecipe;
        try {
          currentRecipe = vm.recipes.firstWhere((r) => r.id == recipe.id);
        } catch (e) {
          // Якщо рецепт не знайдено (наприклад, видалено), використовуємо старий як заглушку
          currentRecipe = recipe;
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFFFBF0),
          appBar: AppBar(
            backgroundColor: const Color(0xFFABBA72),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF4B572B)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'RECIPE CARD',
              style: TextStyle(
                color: const Color(0xFF4B572B),
                fontSize: titleFontSize,
                fontFamily: 'Kantumruy Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              _buildActionButton(
                iconPath: 'assets/images/edit_icon.svg',
                color: const Color(0xFF4B572B),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Передаємо currentRecipe, щоб в форму редагування потрапили найсвіжіші дані
                      builder: (context) => ChangeNotifierProvider.value(
                        value: vm,
                        child: CreateRecipeScreen(recipe: currentRecipe),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                iconPath: 'assets/images/trash.svg',
                color: const Color(0xFF991800),
                onTap: () => _confirmDelete(context, vm),
                marginRight: 16,
              ),
            ],
          ),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: bgLeft,
                top: bgTop,
                child: Container(
                  width: bgWidth,
                  height: bgHeight,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFABBA72),
                    shape: OvalBorder(),
                  ),
                ),
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Зображення (currentRecipe)
                      Center(
                        child: Container(
                          width: imageSize,
                          height: imageSize,
                          decoration: ShapeDecoration(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 15,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: currentRecipe.imageUrl.isNotEmpty
                              ? Image.network(
                            currentRecipe.imageUrl,
                            fit: BoxFit.cover,
                            // Key важливий, щоб Flutter перемалював картинку, якщо URL змінився
                            key: ValueKey(currentRecipe.imageUrl),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: const Color(0xFFABBA72),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholder(imageSize);
                            },
                          )
                              : _buildPlaceholder(imageSize),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Назва (currentRecipe)
                      Text(
                        currentRecipe.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF4B572B),
                          fontSize: titleFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Інформація
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentRecipe.mealType.label,
                            style: TextStyle(
                              color: const Color(0xFF708240),
                              fontSize: subtitleFontSize,
                              fontFamily: 'Kantumruy Pro',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset(
                              'assets/images/fire.svg',
                              width: subtitleFontSize + 2,
                              height: subtitleFontSize + 2,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFDF6149), BlendMode.srcIn),
                            ),
                          ),
                          Text(
                            '${currentRecipe.calories} kcal',
                            style: TextStyle(
                              color: const Color(0xFF708240),
                              fontSize: subtitleFontSize,
                              fontFamily: 'Kantumruy Pro',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Details :',
                          style: TextStyle(
                            color: const Color(0xFF323C15),
                            fontSize: sectionTitleFontSize,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentRecipe.description,
                        style: TextStyle(
                          color: const Color(0xFF708240),
                          fontSize: bodyFontSize,
                          fontFamily: 'Kantumruy Pro',
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0x2BDF6149),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFF49069),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF49069),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Ingredients:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF981800),
                                  fontSize: subtitleFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: currentRecipe.ingredients.map((ingredient) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFDF6149),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            ingredient.name,
                                            style: TextStyle(
                                              color: const Color(0xFF981800),
                                              fontSize: bodyFontSize + 2,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          '|',
                                          style: TextStyle(
                                            color: const Color(0xFFF49069),
                                            fontSize: bodyFontSize + 2,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            ingredient.amount,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF981800),
                                              fontSize: bodyFontSize + 2,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(double imageSize) {
    return Container(
      color: const Color(0xFFE0E0E0),
      child: Icon(
        Icons.restaurant,
        size: imageSize * 0.3,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildActionButton({
    required String iconPath,
    required Color color,
    required VoidCallback onTap,
    double marginRight = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(right: marginRight),
      width: 34,
      height: 34,
      decoration: ShapeDecoration(
        color: const Color(0x7FFFFBF0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: color.withOpacity(0.2),
            highlightColor: color.withOpacity(0.1),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 27,
                height: 27,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}