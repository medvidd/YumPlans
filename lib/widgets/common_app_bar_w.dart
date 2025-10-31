// lib/widgets/common_app_bar_w.dart
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double screenHeight;
  final bool isTablet;

  const CommonAppBar({
    super.key,
    required this.title,
    required this.screenHeight,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = isTablet ? 36 : 28;

    return AppBar(
      backgroundColor: const Color(0xFFABBA72),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF4B572B),
          fontSize: titleFontSize,
          fontFamily: 'Kantumruy Pro',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.07);
}