import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/planner_vm.dart';
import '/viewmodels/recipes_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';
import 'planned_meal_item.dart';
import 'add_planned_meal_screen.dart';
import 'edit_planned_meal_screen.dart';

// 1. Цей віджет тепер ТІЛЬКИ ініціалізує Provider
class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlannerViewModel>(
      create: (_) => PlannerViewModel(),
      // 2. Передаємо управління дочірньому віджету, який матиме доступ до VM
      child: const PlannerView(),
    );
  }
}

// 3. Основна логіка перенесена сюди
class PlannerView extends StatefulWidget {
  const PlannerView({super.key});

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> with WidgetsBindingObserver {
  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

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
      // ТЕПЕР ЦЕ ПРАЦЮВАТИМЕ, бо PlannerView знаходиться ПІД Provider'ом
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
    final bool isTablet = screenWidth > kTabletBreakpoint;

    // Використовуємо Consumer, щоб слухати зміни
    return Consumer<PlannerViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFBF0),
          appBar: CommonAppBar(
            title: 'PLANNER',
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
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72)))
                : vm.errorMessage != null
                ? Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
                : Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: 20.0,
                        ).add(const EdgeInsets.only(bottom: 80.0)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildCalendarToggle(context, vm, isTablet),
                            const SizedBox(height: 16),
                            if (vm.showCalendar)
                              _buildCalendarView(context, vm, isTablet),
                            const SizedBox(height: 16),
                            _buildWeekNavigator(context, vm, isTablet),
                            const SizedBox(height: 16),
                            _buildWeekView(context, vm, isTablet),
                            IgnorePointer(
                              ignoring: vm.showCalendar,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: vm.showCalendar ? 0.3 : 1.0,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    _buildMealsCard(context, vm, isTablet),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildAddButton(context, vm, isTablet),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendarToggle(BuildContext context, PlannerViewModel vm, bool isTablet) {
    final double fontSize = isTablet ? 18 : 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: vm.toggleCalendar,
          child: Text(
            vm.showCalendar ? 'CLOSE CALENDAR' : 'VIEW CALENDAR',
            style: TextStyle(
              color: const Color(0xFFA37F1A),
              fontSize: fontSize,
              fontFamily: 'Kantumruy Pro',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView(BuildContext context, PlannerViewModel vm, bool isTablet) {
    final double arrowSize = isTablet ? 50 : 40;
    final double titleFontSize = isTablet ? 20 : 18;
    final double dayFontSize = isTablet ? 16 : 14;
    final double padding = isTablet ? 16 : 8;

    Widget calendarWidget = Container(
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
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => vm.navigateMonth(false),
                  child: SizedBox(
                    width: arrowSize,
                    height: arrowSize,
                    child: SvgPicture.asset('assets/images/arrow_left.svg'),
                  ),
                ),
                Text(
                  vm.monthFormat.format(vm.focusedMonth),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF49454F),
                    fontSize: titleFontSize,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => vm.navigateMonth(true),
                  child: SizedBox(
                    width: arrowSize,
                    height: arrowSize,
                    child: SvgPicture.asset('assets/images/arrow_right.svg'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
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
                          fontSize: dayFontSize,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: isTablet ? 20 : 10),
        ],
      ),
    );

    if (isTablet) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450.0,
          ),
          child: calendarWidget,
        ),
      );
    }

    return calendarWidget;
  }

  Widget _buildWeekNavigator(BuildContext context, PlannerViewModel vm, bool isTablet) {
    final double arrowSize = isTablet ? 50 : 40;
    final double titleFontSize = isTablet ? 22 : 18;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => vm.navigateWeek(false),
          child: SizedBox(
            width: arrowSize,
            height: arrowSize,
            child: SvgPicture.asset('assets/images/arrow_left.svg'),
          ),
        ),
        Text(
          vm.weekFormat.format(vm.currentDate),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF4B572B),
            fontSize: titleFontSize,
            fontFamily: 'Kantumruy Pro',
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () => vm.navigateWeek(true),
          child: SizedBox(
            width: arrowSize,
            height: arrowSize,
            child: SvgPicture.asset('assets/images/arrow_right.svg'),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekView(BuildContext context, PlannerViewModel vm, bool isTablet) {
    final double dayLetterFontSize = isTablet ? 18 : 16;
    final double dayBoxSize = isTablet ? 60 : 45;
    final double dayNumberFontSize = isTablet ? 18 : 16;

    return Row(
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
                    fontSize: dayLetterFontSize,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: dayBoxSize,
                  height: dayBoxSize,
                  decoration: ShapeDecoration(
                    color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: isSelected
                            ? Colors.transparent
                            : (isToday ? const Color(0xFF708240) : const Color(0xFF959595)),
                      ),
                      borderRadius: BorderRadius.circular(isTablet ? 50 : 50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      vm.dateNumberFormat.format(date),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isToday ? const Color(0xFF708240) : const Color(0xFF959595)),
                        fontSize: dayNumberFontSize,
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
    );
  }

  Widget _buildMealsCard(BuildContext context, PlannerViewModel vm, bool isTablet) {
    final meals = vm.mealsForSelectedDay;

    if (meals.isEmpty) {
      return _buildEmptyState(isTablet);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return PlannedMealItem(
          meal: meals[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: vm),
                    ChangeNotifierProvider(create: (_) => RecipesViewModel()),
                  ],
                  child: EditPlannedMealScreen(
                    plannedMeal: meals[index],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x59DF6149)),
          borderRadius: BorderRadius.circular(27),
        ),
      ),
      child: const Center(
        child: Text(
          'No meals planned for this day',
          style: TextStyle(
            color: Color(0xFF981800),
            fontSize: 16,
            fontFamily: 'Kantumruy Pro',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, PlannerViewModel vm, bool isTablet) {
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
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: vm,
                child: AddPlannedMealScreen(
                  selectedDate: vm.currentDate,
                ),
              ),
            ),
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