import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/groceries_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<GroceriesViewModel>(
      create: (_) => GroceriesViewModel(),
      child: Consumer<GroceriesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),

            appBar: CommonAppBar(
              title: 'GROCERY LIST',
              screenHeight: screenHeight,
              isTablet: isTablet,
            ),

            bottomNavigationBar: BottomNavWidget(
              selectedIndex: vm.selectedIndex,
              onItemSelected: (index) {
                vm.onItemTapped(context, index);
              },
            ),

            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: 20.0,
                      ),
                      child: Column(
                        children: [
                          _buildSegmentedControl(context, vm, isTablet),
                          const SizedBox(height: 24),
                          if (vm.isShoppingListActive)
                            _buildShoppingListContent(context, vm, isTablet)
                          else
                            _buildGroceriesContent(context, vm, isTablet),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context, GroceriesViewModel vm, bool isTablet) {

    final double buttonHeight = isTablet ? 55 : 45;
    final double fontSize = isTablet ? 18 : 16;

    return SizedBox(
      height: buttonHeight,
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
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Kantumruy Pro',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                      fontSize: fontSize,
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
    );
  }

  Widget _buildShoppingListContent(BuildContext context, GroceriesViewModel vm, bool isTablet) {

    final double iconSize = isTablet ? 28 : 22;
    final double titleFontSize = isTablet ? 18 : 16;
    final double buttonIconSize = isTablet ? 32 : 28;
    final double emptyTextFontSize = isTablet ? 18 : 16;
    final double hPadding = isTablet ? 24 : 16;
    final double vPadding = isTablet ? 24 : 16;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
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
                    width: iconSize,
                    height: iconSize,
                    colorFilter: const ColorFilter.mode(Color(0xFF981800), BlendMode.srcIn),
                  ),
                  SizedBox(width: isTablet ? 16 : 10),
                  Text(
                    'Items to buy : 0',
                    style: TextStyle(
                      color: const Color(0xFF981800),
                      fontSize: titleFontSize,
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
                      width: buttonIconSize,
                      height: buttonIconSize,
                      colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/add_circle.svg',
                      width: buttonIconSize,
                      height: buttonIconSize,
                      colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isTablet ? 16 : 8),
          const Divider(color: Color(0xFF708240), height: 1),
          SizedBox(height: isTablet ? 24 : 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 8),
            child: Text(
              'Shopping list is empty',
              style: TextStyle(
                color: const Color(0xFF981800),
                fontSize: emptyTextFontSize,
                fontFamily: 'Kantumruy Pro',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroceriesContent(BuildContext context, GroceriesViewModel vm, bool isTablet) {

    final double emptyTextFontSize = isTablet ? 18 : 16;
    final double hPadding = isTablet ? 24 : 16;
    final double vPadding = isTablet ? 24 : 16;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: vPadding,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x59DF6149)),
          borderRadius: BorderRadius.circular(27),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 8),
        child: Text(
          'No recipes found to get ingredients',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF981800),
            fontSize: emptyTextFontSize,
            fontFamily: 'Kantumruy Pro',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}