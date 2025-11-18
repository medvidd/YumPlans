import 'package:flutter/material.dart';
import '/models/recipe_model.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final bool isSelected;
  final Color selectedColor;

  const RecipeListItem({
    super.key,
    required this.recipe,
    required this.onTap,
    this.isSelected = false,
    this.selectedColor = const Color(0xFFFFC107),
  });

  static const Color _selectedBgColor = Color(0xFFFFF8E1);
  static const Color _selectedBorderColor = Color(0xFFFFC107);

  static const Color _defaultBgColor = Color(0x2BDF6149);
  static const Color _defaultBorderColor = Color(0x59DF6149);

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected ? _selectedBgColor : _defaultBgColor;
    final Color borderColor = isSelected ? _selectedBorderColor : _defaultBorderColor;
    final double borderWidth = isSelected ? 2 : 1;
    final double borderRadius = 10;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),

        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: borderWidth,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          shadows: isSelected ? [
            BoxShadow(
              color: _selectedBorderColor.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: ShapeDecoration(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                recipe.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.restaurant,
                        color: Colors.grey, size: 40),
                  );
                },
              ),
            ),

            const SizedBox(width: 21),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF981800),
                      fontSize: 16,
                      fontFamily: 'Kantumruy Pro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${recipe.mealType.label} | ${recipe.calories} kcal',
                    style: const TextStyle(
                      color: Color(0xFFF49069),
                      fontSize: 14,
                      fontFamily: 'Kantumruy Pro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}