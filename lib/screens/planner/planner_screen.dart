import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:yum_plan/screens/home/home_page.dart';
import 'package:yum_plan/screens/recipes/recipes_list.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int _selectedIndex = 1;

  late DateTime _currentDate;
  bool _showCalendar = false;
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now().toUtc().add(const Duration(hours: 3));
    _focusedMonth = DateTime(_currentDate.year, _currentDate.month, 1);
  }

  void _navigateWeek(bool forward) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month, _currentDate.day + (forward ? 7 : -7));
    });
  }

  void _navigateMonth(bool forward) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + (forward ? 1 : -1), 1);
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showCalendar = !_showCalendar;
                            });
                          },
                          child: Text(
                            _showCalendar ? 'CLOSE CALENDAR' : 'VIEW CALENDAR',
                            style: TextStyle(
                              color: const Color(0xFF708240),
                              fontSize: 16,
                              fontFamily: 'Kantumruy Pro',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_showCalendar)
                    Container(
                      width: 370,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF959595),
                          ),
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 16, right: 12, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _navigateMonth(false),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: SvgPicture.asset('assets/images/arrow_left.svg'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    DateFormat('MMMM yyyy').format(_focusedMonth),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF49454F),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 1.43,
                                      letterSpacing: 0.10,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _navigateMonth(true),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: SvgPicture.asset('assets/images/arrow_right.svg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text('S', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('M', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('T', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('W', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('T', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('F', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                    Text('S', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, height: 1.50, letterSpacing: 0.50)),
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: 42, // Max 6 weeks
                                  itemBuilder: (context, index) {
                                    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday % 7;
                                    final day = index - firstDay + 1;
                                    if (day < 1 || day > DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day) {
                                      return const SizedBox();
                                    }
                                    final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
                                    bool isCurrent = date.year == DateTime.now().toUtc().add(const Duration(hours: 3)).year &&
                                        date.month == DateTime.now().toUtc().add(const Duration(hours: 3)).month &&
                                        date.day == DateTime.now().toUtc().add(const Duration(hours: 3)).day;
                                    bool isSelected = date.year == _currentDate.year && date.month == _currentDate.month && date.day == _currentDate.day;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _currentDate = date;
                                          _showCalendar = false;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: ShapeDecoration(
                                          color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            side: isCurrent ? const BorderSide(width: 2, color: Color(0xFFDF6149)) : const BorderSide(width: 0),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: Text(
                                          day.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : const Color(0xFF1D1B20),
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                            letterSpacing: 0.50,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
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
                          final isCurrent = date.year == _currentDate.year && date.month == _currentDate.month && date.day == _currentDate.day;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentDate = date;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 50,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: isCurrent ? const Color(0xFFDF6149) : Color(0xFFFFFFFF),
                                border: Border.all(
                                  width: 1,
                                  color: isCurrent ? const Color(0xFFDF6149) : const Color(0x59DF6149),
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(16),
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
}