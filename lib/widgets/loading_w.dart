import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: screenHeight * -0.17,
            left: screenWidth * 0.35,
            child: Container(
              width: screenWidth * 0.85,
              height: screenWidth * 0.85,
              decoration: const ShapeDecoration(
                color: Color(0xFFF49069),
                shape: OvalBorder(),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.66,
            left: -screenWidth * 0.42,
            child: Container(
              width: screenWidth * 1.2,
              height: screenWidth * 1.2,
              decoration: const ShapeDecoration(
                color: Color(0xFFABBA72),
                shape: OvalBorder(),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo_yp.svg',
                  width: screenWidth * 0.5,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF4B572B),
                      BlendMode.srcIn
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Transform.scale(
                  scale: isTablet ? 1.5 : 1.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFFFEDC7B),
                    ),
                    backgroundColor: const Color(0xFFD9D9D9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}