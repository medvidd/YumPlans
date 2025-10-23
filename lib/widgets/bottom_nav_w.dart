import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavWidget extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;

  const BottomNavWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
      decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(index: 0, assetName: 'assets/images/home.svg', size: 30),
          _buildNavItem(index: 1, assetName: 'assets/images/calendar.svg', size: 30),
          _buildNavItem(index: 2, assetName: 'assets/images/list.svg', size: 25),
          _buildNavItem(index: 3, assetName: 'assets/images/recipes.svg', size: 35),
          _buildNavItem(index: 4, assetName: 'assets/images/user.svg', size: 30),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String assetName,
    required double size,
  }) {
    final isSelected = selectedIndex == index;
    final iconColor = isSelected ? const Color(0xFFA4801A) : const Color(0xFF8A8A8A);

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? Colors.transparent : const Color(0x2B909090),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SvgPicture.asset(
          assetName,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}