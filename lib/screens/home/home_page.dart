import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:yum_plan/screens/planner/planner_screen.dart';
import 'package:yum_plan/screens/recipes/recipes_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RecipesListScreen()),
        );
        break;
      case 4:
        break;
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('E, dd/MM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      body: Stack(
        children: [
          Positioned(
            left: -105,
            top: -400,
            child: Container(
              width: 621,
              height: 636,
              decoration: const ShapeDecoration(
                color: Color(0xFFABBA72),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 70,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFFBF0),
                    fontSize: 20,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo_plate.svg',
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(width: 11),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 161.18,
                            height: 50,
                            child: Text(
                              'TODAY',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF4B572B),
                                fontSize: 48,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 0),
                          SizedBox(
                            width: 165.57,
                            height: null,
                            child: Text(
                              _getFormattedDate(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.56,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 21,
            top: 250,
            child: Container(
              width: 370,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/clock.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFDF6149),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Text(
                        'Planned meals',
                        style: TextStyle(
                          color: const Color(0xFFDF6149),
                          fontSize: 16,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 370,
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFFBF0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0x59DF6149),
                        ),
                        borderRadius: BorderRadius.circular(27),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Consumed today',
                              style: TextStyle(
                                color: const Color(0xFFA37F1A),
                                fontSize: 20,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '0/0 kcal',
                              style: TextStyle(
                                color: const Color(0xFF708240),
                                fontSize: 18,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              width: 329,
                              height: 28,
                              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                              decoration: ShapeDecoration(
                                color: const Color(0x7AD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 0,
                                    height: 23,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFEDC7B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No meals planned',
                              style: TextStyle(
                                color: const Color(0xFF981800),
                                fontSize: 16,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
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
              decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFEDC7B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/home.svg',
                        width: 30,
                        height: 30,
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
                        color: const Color(0xFFE9E9E9),
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
                        color: const Color(0xFFE9E9E9),
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
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8A8A8A),
                          BlendMode.srcIn,
                        ),
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
                        color: const Color(0xFFE9E9E9),
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
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8A8A8A),
                          BlendMode.srcIn,
                        ),
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
                        color: const Color(0xFFE9E9E9),
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
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8A8A8A),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}