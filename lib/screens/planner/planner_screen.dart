import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:yum_plan/screens/home/home_page.dart'; // Import HomePage for navigation

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int _selectedIndex = 1; // Planner is selected

  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now().toUtc().add(const Duration(hours: 3)); // EEST is UTC+3
  }

  void _navigateWeek(bool forward) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month, _currentDate.day + (forward ? 7 : -7));
    });
  }

  List<DateTime> _getWeekDates() {
    final startOfWeek = _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

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
      // Already on Planner
        break;
      case 2:
      // Navigate to List screen (placeholder)
        break;
      case 3:
      // Navigate to Recipes screen (placeholder)
        break;
      case 4:
      // Navigate to Profile screen (placeholder)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      body: Stack(
        children: [
          Positioned(
            left: -107,
            top: -446,
            child: Container(
              width: 621,
              height: 525,
              decoration: const ShapeDecoration(
                color: Color(0xFFABBA72),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 412,
              height: 79,
              decoration: const BoxDecoration(color: Color(0xFFABBA72)),
              child: const Center(
                child: Text(
                  'PLANNER',
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
            left: 0,
            top: 103,
            child: SizedBox(
              width: 412,
              height: 729,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'VIEW CALENDAR',
                          style: TextStyle(
                            color: const Color(0xFF708240),
                            fontSize: 16,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _navigateWeek(false),
                          child: SvgPicture.asset(
                            'assets/images/arrow_left.svg',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        ..._getWeekDates().map((date) {
                          final isCurrent = date.day == DateTime.now().toUtc().add(const Duration(hours: 3)).day &&
                              date.month == DateTime.now().toUtc().add(const Duration(hours: 3)).month &&
                              date.year == DateTime.now().toUtc().add(const Duration(hours: 3)).year;
                          return Container(
                            width: 40,
                            height: 50,
                            padding: const EdgeInsets.all(2),
                            decoration: ShapeDecoration(
                              color: isCurrent ? const Color(0xFFDF6149) : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0x59DF6149),
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('E').format(date).substring(0, 3),
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white : const Color(0xFF8A8A8A),
                                    fontSize: 14,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white : const Color(0xFF8A8A8A),
                                    fontSize: 14,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        GestureDetector(
                          onTap: () => _navigateWeek(true),
                          child: SvgPicture.asset(
                            'assets/images/arrow_right.svg',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: 382,
                    height: 1,
                    color: const Color(0xFF8A8A8A),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 324,
            top: 729,
            child: GestureDetector(
              onTap: () {
                // Add meal logic
              },
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
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/add_circle.svg',
                    width: 51,
                    height: 51,
                  ),
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
                        colorFilter: const ColorFilter.mode(Color(0xFFA4801A), BlendMode.srcIn),
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
                        colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
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
      ),
    );
  }

  Widget _buildMealRow(String time, String name, String details, Color photoColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF8A8A8A),
            fontSize: 16,
            fontFamily: 'DM Mono',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 14),
        Container(
          width: 286,
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: ShapeDecoration(
            color: const Color(0x2BDF6149),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0x59DF6149),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: ShapeDecoration(
                  color: photoColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 21),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF981800),
                        fontSize: 16,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      details,
                      style: const TextStyle(
                        color: Color(0xFFF49069),
                        fontSize: 14,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/images/edit_icon.svg',
                width: 25,
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}