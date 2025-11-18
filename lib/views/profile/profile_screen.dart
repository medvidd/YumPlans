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
  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            appBar: CommonAppBar(
              title: 'PROFILE',
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
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: 20.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildProfileCard(context, vm, isTablet),
                          const SizedBox(height: 24),
                          _buildStatisticsCard(context, vm, isTablet),
                          const SizedBox(height: 24),
                          _buildSettingsCard(context, vm, isTablet),
                        ],
                      ),
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

  Widget _buildProfileCard(BuildContext context, ProfileViewModel vm, bool isTablet) {

    final double avatarSize = isTablet ? 100 : 70;
    final double avatarIconSize = isTablet ? 60 : 40;
    final double nameFontSize = isTablet ? 24 : 20;
    final double emailFontSize = isTablet ? 18 : 16;
    final double buttonHeight = isTablet ? 55 : 45;
    final double buttonFontSize = isTablet ? 18 : 16;
    final double buttonIconSize = isTablet ? 22 : 18;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 30 : 20),
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
                width: avatarSize,
                height: avatarSize,
                decoration: ShapeDecoration(
                  color: const Color(0x56ABBA72),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF708240)),
                    borderRadius: BorderRadius.circular(avatarSize / 2),
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/user.svg',
                    width: avatarIconSize,
                    height: avatarIconSize,
                    colorFilter: const ColorFilter.mode(Color(0xFF708240), BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(width: isTablet ? 30 : 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.userName,
                      style: TextStyle(
                        color: const Color(0xFF4B572B),
                        fontSize: nameFontSize,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      vm.userEmail,
                      style: TextStyle(
                        color: const Color(0xFF8A8A8A),
                        fontSize: emailFontSize,
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
          SizedBox(height: isTablet ? 30 : 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: buttonHeight,
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
                        width: buttonIconSize,
                        height: buttonIconSize,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    vm.logOut(context);
                  },
                  child: Container(
                    height: buttonHeight,
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
                          width: buttonIconSize,
                          height: buttonIconSize,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
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
    );
  }

  Widget _buildStatisticsCard(BuildContext context, ProfileViewModel vm, bool isTablet) {
    final double titleFontSize = isTablet ? 24 : 20;
    final double bodyFontSize = isTablet ? 18 : 16;
    final double smallFontSize = isTablet ? 16 : 14;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16, vertical: isTablet ? 20 : 15),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Statistics',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: titleFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => _showEditGoalDialog(context, vm),
                child: const Icon(Icons.edit, color: Color(0xFF6C5206), size: 20),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 10 : 5),
          Row(
            children: [
              Text(
                'Calorie goal : ',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: bodyFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${vm.calorieGoal} kcal',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: bodyFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: isTablet ? 30 : 25,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Average : 0 kcal ',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: smallFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Last Week',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: smallFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditGoalDialog(BuildContext context, ProfileViewModel vm) {
    final TextEditingController controller = TextEditingController(text: vm.calorieGoal.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBF0),
          title: const Text('Set Daily Goal', style: TextStyle(color: Color(0xFF4B572B))),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Calories (kcal)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF981800))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFABBA72)),
              onPressed: () {
                vm.updateCalorieGoal(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsCard(BuildContext context, ProfileViewModel vm, bool isTablet) {

    final double titleFontSize = isTablet ? 26 : 22;
    final double itemFontSize = isTablet ? 18 : 16;
    final double iconSize = isTablet ? 28 : 24;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16, vertical: isTablet ? 20 : 10),
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
              fontSize: titleFontSize,
              fontFamily: 'Kantumruy Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingsRow(
            vm: vm,
            isTablet: isTablet,
            iconAsset: 'assets/images/notifications.svg',
            text: 'Notifications',
            fontSize: itemFontSize,
            iconSize: iconSize,
            showSwitch: true,
          ),
          Divider(indent: 1, height: 1, color: Colors.black12),
          _buildSettingsRow(
            vm: vm,
            isTablet: isTablet,
            iconAsset: 'assets/images/lock.svg',
            text: 'Privacy',
            fontSize: itemFontSize,
            iconSize: iconSize,
          ),
          Divider(indent: 1, height: 1, color: Colors.black12),
          _buildSettingsRow(
            vm: vm,
            isTablet: isTablet,
            iconAsset: 'assets/images/help.svg',
            text: 'Help & Support',
            fontSize: itemFontSize,
            iconSize: iconSize,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
    required ProfileViewModel vm,
    required bool isTablet,
    required String iconAsset,
    required String text,
    required double fontSize,
    required double iconSize,
    bool showSwitch = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: Center(
              child: SvgPicture.asset(
                iconAsset,
                width: iconSize * 0.9,
                height: iconSize * 0.9,
                colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: isTablet ? 20 : 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF4B572B),
                fontSize: fontSize,
                fontFamily: 'Kantumruy Pro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (showSwitch)
            SizedBox(
              height: iconSize,
              child: Transform.scale(
                  scale: isTablet ? 0.9 : 0.73,
                  alignment: Alignment.center,
                  child: Switch(
                    value: vm.areNotificationsEnabled,
                    onChanged: (bool newValue) {
                      vm.toggleNotifications(newValue);
                    },
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFFDF6149),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade400,
                  )
              ),
            ),
        ],
      ),
    );
  }
}