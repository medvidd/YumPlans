// lib/widgets/common_app_bar_w.dart
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double screenHeight;

  const CommonAppBar({
    super.key,
    required this.title,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          fontSize: screenWidth * 0.09,
          fontFamily: 'Kantumruy Pro',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.1);
}