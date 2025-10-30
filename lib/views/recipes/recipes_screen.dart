import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/recipes_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<RecipesViewModel>(
      create: (_) => RecipesViewModel(),
      child: Consumer<RecipesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            appBar: CommonAppBar(
              title: 'MY RECIPES',
              screenHeight: screenHeight,
            ),
            bottomNavigationBar: BottomNavWidget(
              selectedIndex: vm.selectedIndex,
              onItemSelected: (index) {
                vm.onItemTapped(context, index);
              },
            ),
            body: SafeArea(
              child: SizedBox(
                height: screenHeight,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: screenHeight * 0.03),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: TextField(
                                controller: vm.searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search by name, ingredient, or tag',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF4B572B),
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF4B572B),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x4CE7FCB1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFABBA72),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF4B572B),
                                      width: 1.5,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                  ),
                                ),
                                style: TextStyle(
                                  color: const Color(0xFF4B572B),
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.03,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFFBF0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0x59DF6149),
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No recipes',
                                      style: TextStyle(
                                        color: const Color(0xFF981800),
                                        fontSize: screenWidth * 0.04,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      right: screenWidth * 0.05,
                      bottom: screenHeight * 0.02,
                      child: GestureDetector(
                        child: SizedBox(
                          width: screenWidth * 0.14,
                          height: screenWidth * 0.14,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: const ShapeDecoration(
                                  color: Color(0x7FFFFBF0),
                                  shape: OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 7.60,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/add_circle.svg',
                                width: screenWidth * 0.13,
                                height: screenWidth * 0.13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}