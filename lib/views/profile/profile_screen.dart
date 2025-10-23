import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/profile_vm.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            body: Container(
              width: 412,
              height: 892,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 412,
                      height: 79,
                      decoration: const BoxDecoration(color: Color(0xFFABBA72)),
                      child: const Center(
                        child: Text(
                          'PROFILE',
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
                  top: 119,
                  left: 21,
                  right: 21,
                  child: Container(
                    width: 370,
                    height: 640,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 28,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 12,
                            children: [
                            Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(27),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFE0E0E0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 75,
                                      height: 75,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x56ABBA72),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Color(0xFF708240)),
                                          borderRadius: BorderRadius.circular(37.50),
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/user.svg',
                                          width: 45,
                                          height: 45,
                                          colorFilter: const ColorFilter.mode(Color(0xFF708240), BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Name Surname',
                                            style: TextStyle(
                                              color: Color(0xFF4B572B),
                                              fontSize: 20,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const Text(
                                            'namesurname@gmail.com',
                                            style: TextStyle(
                                              color: Color(0xFF8A8A8A),
                                              fontSize: 16,
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

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
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
                                              width: 18,
                                              height: 18,
                                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Edit Profile',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 15),

                                    Expanded(
                                      child: Container(
                                        height: 40,
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
                                              width: 18,
                                              height: 18,
                                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Log Out',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
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

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                          decoration: ShapeDecoration(
                            color: const Color(0x99FEDC7B),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0x3FA37F1A),
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 3,
                            children: [
                              SizedBox(
                                width: 352,
                                height: 27,
                                child: Text(
                                  'My Statistics',
                                  style: TextStyle(
                                    color: const Color(0xFF6C5206),
                                    fontSize: 20,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 13,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        'Calorie goal : ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF6C5206),
                                          fontSize: 16,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '0 kcal',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF6C5206),
                                          fontSize: 20,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 47,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 7,
                                  children: [
                                    Container(
                                      width: 340,
                                      height: 28,
                                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 340,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 3,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        'Average : 0 kcal ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: const Color(0xFF6C5206),
                                          fontSize: 14,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 76,
                                      child: Text(
                                        'Last Week',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: const Color(0xFF6C5206),
                                          fontSize: 14,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 3,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Settings',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: const Color(0xFF4B572B),
                                        fontSize: 24,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ),
                                ]
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/notifications.svg',
                                        width: 28,
                                        height: 28,
                                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  const Expanded(
                                    child: Text(
                                      'Notifications',
                                      style: TextStyle(
                                        color: Color(0xFF4B572B),
                                        fontSize: 16,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.75,
                                    child: Switch(
                                      value: true,
                                      onChanged: (bool value) {},
                                      activeColor: Colors.white,
                                      activeTrackColor: const Color(0xFFDF6149),
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(indent: 55, height: 1, color: Colors.black12),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 2),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/lock.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                      child: Text(
                                        'Privacy',
                                        style: TextStyle(
                                          color: Color(0xFF4B572B),
                                          fontSize: 16,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Divider(indent: 55, height: 1, color: Colors.black12),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/help.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    const Expanded(
                                      child: Text(
                                        'Help & Support',
                                        style: TextStyle(
                                          color: Color(0xFF4B572B),
                                          fontSize: 16,
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
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
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
                                colorFilter: const ColorFilter.mode(Color(0xFFA4801A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
