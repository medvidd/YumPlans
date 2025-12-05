import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/home_page_vm.dart';
import '/viewmodels/recipes_vm.dart';
import '/viewmodels/planner_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/views/planner/planned_meal_item.dart';
import '/views/planner/edit_planned_meal_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with WidgetsBindingObserver {
  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 700.0;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<HomePageViewModel>(
      create: (_) => HomePageViewModel(),
      child: Consumer<HomePageViewModel>(
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
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72)))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildHeader(context, vm, isTablet, screenWidth, screenHeight),
                  _buildBody(context, vm, isTablet),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomePageViewModel vm, bool isTablet, double screenWidth, double screenHeight) {
    final double headerHeight = isTablet ? 300 : 200;
    final double welcomeFontSize = isTablet ? 28 : 20;
    final double logoSize = isTablet ? 125 : 95;
    final double todayTitleHeight = isTablet ? 75 : 50;
    final double dateTitleHeight = isTablet ? 48 : 34;

    final top = isTablet ? -screenHeight * 0.5 : -screenHeight * 0.7;
    final left = isTablet ? -screenWidth * 0.15 : -screenWidth * 0.25;
    final width = isTablet ? screenWidth * 1.3 : screenWidth * 1.5;
    final height = isTablet ? screenHeight * 0.7 : screenHeight * 0.94;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: left,
            top: top,
            child: Container(
              width: width,
              height: height,
              decoration: const ShapeDecoration(
                color: Color(0xFFABBA72),
                shape: OvalBorder(),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Column(
                    children: [
                      Text(
                        'Welcome back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFFFFBF0),
                          fontSize: welcomeFontSize,
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
                            width: logoSize,
                            height: logoSize,
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            height: logoSize,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: todayTitleHeight,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'TODAY',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: const Color(0xFF4B572B),
                                        fontSize: 100,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: dateTitleHeight,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      vm.formattedDate,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 100,
                                        fontFamily: 'Fredoka',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.56,
                                      ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomePageViewModel vm, bool isTablet) {
    final double smallIconSize = isTablet ? 26 : 22;
    final double plannedMealsFontSize = isTablet ? 18 : 16;
    final double cardTitleFontSize = isTablet ? 20 : 18;
    final double cardKcalFontSize = isTablet ? 18 : 16;
    final double noMealsFontSize = isTablet ? 18 : 16;

    double progress = 0.0;
    if (vm.dailyCalorieGoal > 0) {
      progress = (vm.consumedCalories / vm.dailyCalorieGoal).clamp(0.0, 1.0);
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            kHorizontalPadding,
            25.0,
            kHorizontalPadding,
            40.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/clock.svg',
                        width: smallIconSize,
                        height: smallIconSize,
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
                          fontSize: plannedMealsFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
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
                                fontSize: cardTitleFontSize,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${vm.consumedCalories}/${vm.dailyCalorieGoal} kcal',
                              style: TextStyle(
                                color: const Color(0xFF708240),
                                fontSize: cardKcalFontSize,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Container(
                              width: double.infinity,
                              height: 28,
                              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2.5),
                              decoration: ShapeDecoration(
                                color: const Color(0x7AD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFEDC7B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        if (vm.todayMeals.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'No meals planned',
                                style: TextStyle(
                                  color: const Color(0xFF981800),
                                  fontSize: noMealsFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: vm.todayMeals.length,
                            itemBuilder: (context, index) {
                              return PlannedMealItem(
                                meal: vm.todayMeals[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(create: (_) => PlannerViewModel()),
                                          ChangeNotifierProvider(create: (_) => RecipesViewModel()),
                                        ],
                                        child: EditPlannedMealScreen(
                                          plannedMeal: vm.todayMeals[index],
                                        ),
                                      ),
                                    ),
                                  ).then((_) {
                                    vm.refreshData();
                                  });
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}