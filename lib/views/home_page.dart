import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/home_page_vm.dart';
import '/widgets/bottom_nav_w.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

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

              child: SizedBox(
                height: screenHeight,
                child: Stack(
                  children: [
                    Positioned(
                      left: -screenWidth * 0.25,
                      top: -screenHeight * 0.47,
                      child: Container(
                        width: screenWidth * 1.5,
                        height: screenHeight * 0.71,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFABBA72),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.06),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: Column(
                              children: [
                                Text(
                                  'Welcome back!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFFFFFBF0),
                                    fontSize: screenWidth * 0.050,
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
                                      width: screenWidth * 0.20,
                                      height: screenWidth * 0.20,
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      height: screenWidth * 0.25,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.39,
                                            height: screenWidth * 0.12,
                                            child: Text(
                                              'TODAY',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: const Color(0xFF4B572B),
                                                fontSize: screenWidth * 0.107,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 0),
                                          SizedBox(
                                            width: screenWidth * 0.40,
                                            child: Text(
                                              vm.formattedDate,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth * 0.068,
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
                          const SizedBox(height: 40),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/clock.svg',
                                      width: screenWidth * 0.048,
                                      height: screenWidth * 0.048,
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
                                        fontSize: screenWidth * 0.039,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 22),
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Consumed today',
                                            style: TextStyle(
                                              color: const Color(0xFFA37F1A),
                                              fontSize: screenWidth * 0.048,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '0/0 kcal',
                                            style: TextStyle(
                                              color: const Color(0xFF708240),
                                              fontSize: screenWidth * 0.044,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Container(
                                            width: double.infinity,
                                            height: 28,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 5),
                                            decoration: ShapeDecoration(
                                              color: const Color(0x7AD9D9D9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(40),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 0,
                                                  height: 23,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(
                                                        0xFFFEDC7B),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(50),
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
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'No meals planned',
                                            style: TextStyle(
                                              color: const Color(0xFF981800),
                                              fontSize: screenWidth * 0.039,
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
                        ],
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