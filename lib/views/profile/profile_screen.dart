import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/profile_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            appBar: CommonAppBar(
              title: 'PROFILE',
              screenHeight: screenHeight,
            ),
            bottomNavigationBar: BottomNavWidget(
              selectedIndex: vm.selectedIndex,
              onItemSelected: (index) {
                vm.onItemTapped(context, index);
              },
            ),
            body: SafeArea(
              child: SizedBox(
                height: screenHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenHeight * 0.03),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(27),
                                  border: Border.all(color: const Color(0xFFE0E0E0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.18,
                                          height: screenWidth * 0.18,
                                          decoration: ShapeDecoration(
                                            color: const Color(0x56ABBA72),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(color: Color(0xFF708240)),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.09),
                                            ),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/images/user.svg',
                                              width: screenWidth * 0.11,
                                              height: screenWidth * 0.11,
                                              colorFilter: const ColorFilter.mode(Color(0xFF708240), BlendMode.srcIn),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.07),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name Surname',
                                                style: TextStyle(
                                                  color: const Color(0xFF4B572B),
                                                  fontSize: screenWidth * 0.05,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'namesurname@gmail.com',
                                                style: TextStyle(
                                                  color: const Color(0xFF8A8A8A),
                                                  fontSize: screenWidth * 0.04,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w300,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.025),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: screenHeight * 0.05,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF4B572B),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/edit_icon.svg',
                                                  width: screenWidth * 0.045,
                                                  height: screenWidth * 0.045,
                                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                ),
                                                SizedBox(width: screenWidth * 0.03),
                                                Text(
                                                  'Edit Profile',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: screenWidth * 0.038,
                                                    fontFamily: 'Kantumruy Pro',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.04),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              vm.logOut(context);
                                            },
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFDF6149),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/log_out.svg',
                                                    width: screenWidth * 0.045,
                                                    height: screenWidth * 0.045,
                                                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                  ),
                                                  SizedBox(width: screenWidth * 0.03),
                                                  Text(
                                                    'Log Out',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: screenWidth * 0.038,
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
                                  ],
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.03),

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.015),
                                decoration: ShapeDecoration(
                                  color: const Color(0x99FEDC7B),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Color(0x3FA37F1A)),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Statistics',
                                      style: TextStyle(
                                        color: const Color(0xFF6C5206),
                                        fontSize: screenWidth * 0.05,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Row(
                                      children: [
                                        Text(
                                          'Calorie goal : ',
                                          style: TextStyle(
                                            color: const Color(0xFF6C5206),
                                            fontSize: screenWidth * 0.04,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '0 kcal',
                                          style: TextStyle(
                                            color: const Color(0xFF6C5206),
                                            fontSize: screenWidth * 0.05,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Container(
                                      height: screenHeight * 0.03,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Average : 0 kcal ',
                                          style: TextStyle(
                                            color: const Color(0xFF6C5206),
                                            fontSize: screenWidth * 0.035,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Last Week',
                                          style: TextStyle(
                                            color: const Color(0xFF6C5206),
                                            fontSize: screenWidth * 0.035,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.03),

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(27),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Settings',
                                      style: TextStyle(
                                        color: const Color(0xFF4B572B),
                                        fontSize: screenWidth * 0.06,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.001),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.06,
                                            height: screenWidth * 0.06,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/images/notifications.svg',
                                                width: screenWidth * 0.05,
                                                height: screenWidth * 0.05,
                                                colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.04),
                                          Expanded(
                                            child: Text(
                                              'Notifications',
                                              style: TextStyle(
                                                color: const Color(0xFF4B572B),
                                                fontSize: screenWidth * 0.04,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenWidth * 0.06,
                                            child: Transform.scale(
                                              scale: 0.73,
                                              alignment: Alignment.center,
                                              child: Switch(
                                                value: vm.areNotificationsEnabled,
                                                onChanged: (bool newValue) {
                                                  vm.toggleNotifications(newValue);
                                                },
                                                activeColor: Colors.white,
                                                activeTrackColor: const Color(0xFFDF6149),
                                                inactiveThumbColor: Colors.white,
                                                inactiveTrackColor: Colors.grey.shade400,
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(indent: screenWidth * 0.001, height: 1, color: Colors.black12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.06,
                                            height: screenWidth * 0.06,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/images/lock.svg',
                                                width: screenWidth * 0.05,
                                                height: screenWidth * 0.05,
                                                colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.04),
                                          Expanded(
                                            child: Text(
                                              'Privacy',
                                              style: TextStyle(
                                                color: const Color(0xFF4B572B),
                                                fontSize: screenWidth * 0.04,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(indent: screenWidth * 0.001, height: 1, color: Colors.black12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.06,
                                            height: screenWidth * 0.06,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/images/help.svg',
                                                width: screenWidth * 0.05,
                                                height: screenWidth * 0.05,
                                                colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.04),
                                          Expanded(
                                            child: Text(
                                              'Help & Support',
                                              style: TextStyle(
                                                color: const Color(0xFF4B572B),
                                                fontSize: screenWidth * 0.04,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}