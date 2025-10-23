import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/planner_vm.dart';

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlannerViewModel>(
      create: (_) => PlannerViewModel(),
      child: Consumer<PlannerViewModel>(
        builder: (context, vm, child) {
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
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [GestureDetector(onTap: vm.toggleCalendar, child: Text(vm.showCalendar ? 'CLOSE CALENDAR' : 'VIEW CALENDAR', style: TextStyle(color: const Color(0xFFA37F1A), fontSize: 16, fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.w500, decoration: TextDecoration.underline)))]),
                        ),
                        if (vm.showCalendar)
                          Container(
                            width: 370,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFF959595)), borderRadius: BorderRadius.circular(28))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4, left: 16, right: 12, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(onTap: () => vm.navigateMonth(false), child: Container(width: 48, height: 48, child: SvgPicture.asset('assets/images/arrow_left.svg'))),
                                      Text(vm.monthFormat.format(vm.focusedMonth), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF49454F), fontSize: 16, fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.w500)),
                                      GestureDetector(onTap: () => vm.navigateMonth(true), child: Container(width: 48, height: 48, child: SvgPicture.asset('assets/images/arrow_right.svg'))),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                                    itemCount: vm.getDaysInMonth().length,
                                    itemBuilder: (context, index) {
                                      final date = vm.getDaysInMonth()[index];
                                      if (date == null) return const SizedBox();
                                      final isSelected = date.year == vm.currentDate.year && date.month == vm.currentDate.month && date.day == vm.currentDate.day;

                                      final isToday = date.year == vm.today.year && date.month == vm.today.month && date.day == vm.today.day;

                                      return GestureDetector(
                                        onTap: () => vm.selectDate(date),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                              color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                side: isToday && !isSelected ? const BorderSide(width: 2, color: Color(0xFF708240)) : BorderSide.none,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Text(date.day.toString(), style: TextStyle(fontFamily: 'Kantumruy Pro', color: isSelected ? Colors.white : const Color(0xFF1D1B20), fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(onTap: () => vm.navigateWeek(false), child: Container(width: 48, height: 48, child: SvgPicture.asset('assets/images/arrow_left.svg'))),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), child: Text(vm.weekFormat.format(vm.currentDate), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF4B572B), fontSize: 18, fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.w700))),
                              GestureDetector(onTap: () => vm.navigateWeek(true), child: Container(width: 48, height: 48, child: SvgPicture.asset('assets/images/arrow_right.svg'))),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Row(
                            children: vm.getWeekDates().map((date) {
                              final isSelected = date.year == vm.currentDate.year && date.month == vm.currentDate.month && date.day == vm.currentDate.day;

                              final isToday = date.year == vm.today.year && date.month == vm.today.month && date.day == vm.today.day;

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => vm.selectDate(date),
                                  child: Column(
                                    children: [
                                      Text(vm.dayFormat.format(date).substring(0, 1), style: TextStyle(color: const Color(0xFF49454F), fontSize: 16, fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 2, color: isSelected ? Colors.transparent : (isToday ? const Color(0xFF708240) : const Color(0xFF959595))),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Center(child: Text(vm.dateNumberFormat.format(date), style: TextStyle(color: isSelected ? Colors.white : (isToday ? const Color(0xFF708240) : const Color(0xFF959595)), fontSize: 16, fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.w700))),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 16),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 4),
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
                              colorFilter: const ColorFilter.mode(Color(0xFFA4801A), BlendMode.srcIn),
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
                              colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
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
          );
        },
      ),
    );
  }
}