import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '/models/planner_model.dart';

class PlannedMealItem extends StatelessWidget {
  final PlannedMeal meal;
  final VoidCallback onTap;

  const PlannedMealItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              width: 60,
              child: Text(
                DateFormat('HH:mm').format(meal.dateTime),
                style: const TextStyle(
                  color: Color(0xFF8A8A8A),
                  fontSize: 16,
                  fontFamily: 'DM Mono',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: ShapeDecoration(
                  color: const Color(0x2BDF6149),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0x59DF6149)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        meal.recipe.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.restaurant, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.recipe.title,
                            maxLines: 1,
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
                            '${meal.mealType} | ${meal.recipe.calories} kcal',
                            style: const TextStyle(
                              color: Color(0xFFF49069),
                              fontSize: 13,
                              fontFamily: 'Kantumruy Pro',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        'assets/images/edit_square.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}