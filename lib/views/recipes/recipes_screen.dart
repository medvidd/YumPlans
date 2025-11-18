import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/recipes_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';
import 'recipe_list_item.dart';
import 'recipe_details_screen.dart';
import 'create_recipe_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<RecipesViewModel>(
      create: (_) => RecipesViewModel(),
      child: Consumer<RecipesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            appBar: CommonAppBar(
              title: 'MY RECIPES',
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: 20.0,
                        ),
                        child: Column(
                          children: [
                            _buildSearchBar(context, vm, isTablet),
                            const SizedBox(height: 24),
                            Expanded(
                              child: _buildRecipeList(context, vm, isTablet),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildAddButton(context, isTablet),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecipeList(BuildContext context, RecipesViewModel vm, bool isTablet) {
    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFABBA72)),
      );
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Color(0xFF981800)),
            const SizedBox(height: 16),
            Text(
              vm.errorMessage!,
              style: const TextStyle(
                color: Color(0xFF981800),
                fontSize: 16,
                fontFamily: 'Kantumruy Pro',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: vm.fetchRecipes,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFABBA72),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }

    if (vm.recipes.isEmpty) {
      return _buildNoRecipesCard(context, vm, isTablet);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80.0),
      itemCount: vm.recipes.length,
      itemBuilder: (context, index) {
        final recipe = vm.recipes[index];
        return RecipeListItem(
          recipe: recipe,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailsScreen(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context, RecipesViewModel vm, bool isTablet) {
    final double fieldHeight = isTablet ? 60 : 55;
    final double fontSize = isTablet ? 18 : 16;
    final double iconSize = isTablet ? 28 : 24;

    return TextField(
      controller: vm.searchController,
      decoration: InputDecoration(
        hintText: 'Search by name, ingredient, or tag',
        hintStyle: TextStyle(
          color: const Color(0xFF4B572B),
          fontSize: fontSize,
          fontFamily: 'Kantumruy Pro',
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Icon(
            Icons.search,
            color: const Color(0xFF4B572B),
            size: iconSize,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
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
          vertical: (fieldHeight - (fontSize * 1.5)) / 2,
        ),
      ),
      style: TextStyle(
        color: const Color(0xFF4B572B),
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildNoRecipesCard(BuildContext context, RecipesViewModel vm, bool isTablet) {
    final double fontSize = isTablet ? 18 : 16;
    final double vPadding = isTablet ? 40 : 30;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: vPadding,
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
              fontSize: fontSize,
              fontFamily: 'Kantumruy Pro',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isTablet) {
    final double buttonSize = isTablet ? 70 : 55;
    final double bottomPadding = isTablet ? 30 : 20;
    final double rightPadding = isTablet ? 30 : 20;

    return Positioned(
      right: rightPadding,
      bottom: bottomPadding,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateRecipeScreen()),
          );
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Stack(
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
              Center(
                child: SvgPicture.asset(
                  'assets/images/add_circle.svg',
                  width: buttonSize * 0.95,
                  height: buttonSize * 0.95,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}