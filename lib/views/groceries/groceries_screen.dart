import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/groceries_vm.dart';
import '/widgets/bottom_nav_w.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<GroceriesViewModel>(
      create: (_) => GroceriesViewModel(),
      child: Consumer<GroceriesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            bottomNavigationBar: BottomNavWidget(
              selectedIndex: vm.selectedIndex,
              onItemSelected: (index) {
                vm.onItemTapped(context, index);
              },
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.1,
                        color: const Color(0xFFABBA72),
                        child: Center(
                          child: Text(
                            'GROCERY LIST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF4B572B),
                              fontSize: screenWidth * 0.09,
                              fontFamily: 'Kantumruy Pro',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                        child: SizedBox(
                          height: screenHeight * 0.05,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: vm.selectShoppingList,
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x4CE7FCB1),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0xFFABBA72),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Shopping List',
                                        style: TextStyle(
                                          color: vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B),
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Kantumruy Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: vm.selectGroceries,
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: !vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x4CE7FCB1),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: !vm.isShoppingListActive ? Colors.white : const Color(0xFFABBA72),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Groceries',
                                        style: TextStyle(
                                          color: !vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B),
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Kantumruy Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      if (vm.isShoppingListActive)
                        _buildShoppingListContent(screenWidth, screenHeight)
                      else
                        _buildGroceriesContent(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShoppingListContent(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        width: screenWidth * 0.9,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.025,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFFFFBF0),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x59DF6149)),
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/clock.svg',
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
                      colorFilter: const ColorFilter.mode(Color(0xFF981800), BlendMode.srcIn),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Items to buy : 0',
                      style: TextStyle(
                        color: const Color(0xFF981800),
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/edit_icon.svg',
                        width: screenWidth * 0.07,
                        height: screenWidth * 0.07,
                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/add_circle.svg',
                        width: screenWidth * 0.075,
                        height: screenWidth * 0.075,
                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            const Divider(color: Color(0xFF708240), height: 1),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                'Shopping list is empty',
                style: TextStyle(
                  color: const Color(0xFF981800),
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroceriesContent(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        width: screenWidth * 0.9,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.025,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFFFFBF0),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x59DF6149)),
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: Text(
            'No recipes found to get ingredients',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF981800),
              fontSize: screenWidth * 0.04,
              fontFamily: 'Kantumruy Pro',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}