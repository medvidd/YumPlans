import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yum_plan/screens/home/home_page.dart'; // Import HomePage
import 'package:yum_plan/screens/planner/planner_screen.dart'; // Import PlannerScreen

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({super.key});

  @override
  _RecipesListScreenState createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  int _selectedIndex = 3; // Recipes tab is selected by default

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PlannerScreen()),
        );
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFBF0), // Колір фону тепер тут
        body: Container(
        width: 412,
        height: 892,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
        child: Stack(
        children: [
          Positioned(
            left: 21,
            top: 207,
            child: Container(
              width: 370,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No recipes',
                    style: TextStyle(
                      color: const Color(0xFF981800),
                      fontSize: 16,
                      fontFamily: 'Kantumruy Pro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            ),
          ),
          Positioned(
            left: 21,
            top: 118,
            child: Container(
              width: 370,
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, ingredient, or tag',
                  hintStyle: const TextStyle(
                    color: Color(0xFF4B572B),
                    fontSize: 16,
                    fontFamily: 'Roboto',
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
                          shape: OvalBorder(),
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
            left: -105,
            top: -447,
            child: Container(
              width: 621,
              height: 525,
              child: Stack(
                children: [
                  Positioned(
                    left: 104,
                    top: 446,
                    child: Container(
                      width: 415,
                      height: 79,
                      decoration: BoxDecoration(color: Color(0xFFABBA72)),
                    ),
                  ),
                  const Positioned(
                    left: 202.97,
                    top: 464.59,
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
                ],
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
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: _selectedIndex == 0 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x2B909090),
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
                    onTap: () => _onItemTapped(1),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: _selectedIndex == 1 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x2B909090),
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
                    onTap: () => _onItemTapped(2),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: _selectedIndex == 2 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x2B909090),
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
                    onTap: () => _onItemTapped(3),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: _selectedIndex == 3 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x2B909090),
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
                    onTap: () => _onItemTapped(4),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: _selectedIndex == 4 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x2B909090),
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
        ) ),
    );
  }
}