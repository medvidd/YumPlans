import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/recipes_vm.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipesViewModel>(
      create: (_) => RecipesViewModel(),
      child: Consumer<RecipesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            body: Container(
              width: 412,
              height: 892,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 412,
                      height: 79,
                      decoration: const BoxDecoration(color: Color(0xFFABBA72)),
                      child: const Center(
                        child: Text(
                          'MY RECIPES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4B572B),
                            fontSize: 36,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 103,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 370,
                          height: 48,
                          child: TextField(
                            controller: vm.searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name, ingredient, or tag',
                              hintStyle: const TextStyle(
                                color: Color(0xFF4B572B),
                                fontSize: 16,
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
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF4B572B),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: 370,
                          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
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
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                'No recipes',
                                style: TextStyle(
                                  color: Color(0xFF981800),
                                  fontSize: 16,
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

                  Positioned(
                    left: 324,
                    top: 729,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 55,
                        height: 55,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: ShapeDecoration(
                                  color: const Color(0x7FFFFBF0),
                                  shape: const OvalBorder(),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 7.60,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2,
                              top: 2,
                              child: Container(
                                width: 51,
                                height: 51,
                                child: SvgPicture.asset('assets/images/add_circle.svg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 825,
                    child: Container(
                      width: 412,
                      height: 67,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                      decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 0),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 0 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 0 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/home.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 1),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 1 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 1 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/calendar.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 2),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 2 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 2 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/list.svg',
                                width: 25,
                                height: 25,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 3),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 3 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 3 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/recipes.svg',
                                width: 35,
                                height: 35,
                                colorFilter: const ColorFilter.mode(Color(0xFFA4801A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 4),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 4 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 4 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/user.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}