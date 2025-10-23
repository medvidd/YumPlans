import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/planner_vm.dart';
import '/widgets/bottom_nav_w.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<PlannerViewModel>(context, listen: false).updateTodayIfNeeded();
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<PlannerViewModel>(
      create: (_) => PlannerViewModel(),
      child: Consumer<PlannerViewModel>(
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
              child: SizedBox(
                height: screenHeight,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.0001, bottom: screenHeight * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * 0.1,
                                color: const Color(0xFFABBA72),
                                child: Center(
                                  child: Text(
                                    'PLANNER',
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
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: vm.toggleCalendar,
                                    child: Text(
                                      vm.showCalendar ? 'CLOSE CALENDAR' : 'VIEW CALENDAR',
                                      style: TextStyle(
                                        color: const Color(0xFFA37F1A),
                                        fontSize: screenWidth * 0.04,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (vm.showCalendar)
                              Container(
                                width: screenWidth * 0.9,
                                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFF959595)),
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: screenHeight * 0.005,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => vm.navigateMonth(false),
                                            child: SizedBox(
                                              width: screenWidth * 0.12,
                                              height: screenWidth * 0.12,
                                              child: SvgPicture.asset('assets/images/arrow_left.svg'),
                                            ),
                                          ),
                                          Text(
                                            vm.monthFormat.format(vm.focusedMonth),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF49454F),
                                              fontSize: screenWidth * 0.04,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => vm.navigateMonth(true),
                                            child: SizedBox(
                                              width: screenWidth * 0.12,
                                              height: screenWidth * 0.12,
                                              child: SvgPicture.asset('assets/images/arrow_right.svg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                        ),
                                        itemCount: vm.getDaysInMonth().length,
                                        itemBuilder: (context, index) {
                                          final date = vm.getDaysInMonth()[index];
                                          if (date == null) return const SizedBox();
                                          final isSelected = _isSameDay(date, vm.currentDate);
                                          final isToday = _isSameDay(date, vm.today);

                                          return GestureDetector(
                                            onTap: () => vm.selectDate(date),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: ShapeDecoration(
                                                  color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    side: isToday && !isSelected
                                                        ? const BorderSide(width: 2, color: Color(0xFF708240))
                                                        : BorderSide.none,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                ),
                                                child: Text(
                                                  date.day.toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Kantumruy Pro',
                                                    color: isSelected ? Colors.white : const Color(0xFF1D1B20),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: screenWidth * 0.035,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                  ],
                                ),
                              ),

                            SizedBox(height: screenHeight * 0.02),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => vm.navigateWeek(false),
                                    child: SizedBox(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      child: SvgPicture.asset('assets/images/arrow_left.svg'),
                                    ),
                                  ),
                                  Text(
                                    vm.weekFormat.format(vm.currentDate),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF4B572B),
                                      fontSize: screenWidth * 0.045,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => vm.navigateWeek(true),
                                    child: SizedBox(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      child: SvgPicture.asset('assets/images/arrow_right.svg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.02),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Row(
                                children: vm.getWeekDates().map((date) {
                                  final isSelected = _isSameDay(date, vm.currentDate);
                                  final isToday = _isSameDay(date, vm.today);

                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () => vm.selectDate(date),
                                      child: Column(
                                        children: [
                                          Text(
                                            vm.dayFormat.format(date).substring(0, 1),
                                            style: TextStyle(
                                              color: const Color(0xFF49454F),
                                              fontSize: screenWidth * 0.04,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            width: screenWidth * 0.1,
                                            height: screenWidth * 0.1,
                                            decoration: ShapeDecoration(
                                              color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 2,
                                                  color: isSelected
                                                      ? Colors.transparent
                                                      : (isToday ? const Color(0xFF708240) : const Color(0xFF959595)),
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                vm.dateNumberFormat.format(date),
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : (isToday ? const Color(0xFF708240) : const Color(0xFF959595)),
                                                  fontSize: screenWidth * 0.04,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            Container(
                              width: screenWidth * 0.9,
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
                                    'No meals planned',
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
                                  width: screenWidth * 0.13,
                                  height: screenWidth * 0.13,
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
          );
        },
      ),
    );
  }
}