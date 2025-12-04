import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/profile_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';
import '../../fb_services/upload_service.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Константи стилю
  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

  // Кольори проекту
  final Color primaryGreen = const Color(0xFF4B572B);
  final Color lightGreen = const Color(0xFFABBA72);
  final Color bgCream = const Color(0xFFFFFBF0);
  final Color accentOrange = const Color(0xFFDF6149);

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
            backgroundColor: bgCream,
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

  // --- КАРТКА ПРОФІЛЮ ---
  Widget _buildProfileCard(BuildContext context, ProfileViewModel vm, bool isTablet) {
    final double avatarSize = isTablet ? 100 : 70;

    // Відображення аватара: якщо є URL, показуємо картинку, інакше SVG
    Widget avatarWidget;
    if (vm.photoUrl != null && vm.photoUrl!.isNotEmpty) {
      avatarWidget = ClipRRect(
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: Image.network(
          vm.photoUrl!,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(avatarSize, isTablet),
        ),
      );
    } else {
      avatarWidget = _buildDefaultAvatar(avatarSize, isTablet);
    }

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
                child: Center(child: avatarWidget),
              ),
              SizedBox(width: isTablet ? 30 : 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.userName,
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: isTablet ? 24 : 20,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      vm.userEmail,
                      style: TextStyle(
                        color: const Color(0xFF8A8A8A),
                        fontSize: isTablet ? 18 : 16,
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
                child: GestureDetector(
                  onTap: () => _showEditProfileDialog(context, vm),
                  child: Container(
                    height: isTablet ? 55 : 45,
                    decoration: ShapeDecoration(
                      color: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/edit_icon.svg',
                          width: isTablet ? 22 : 18,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 18 : 16,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => vm.logOut(context),
                  child: Container(
                    height: isTablet ? 55 : 45,
                    decoration: ShapeDecoration(
                      color: accentOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/log_out.svg',
                          width: isTablet ? 22 : 18,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 18 : 16,
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

  Widget _buildDefaultAvatar(double size, bool isTablet) {
    return SvgPicture.asset(
      'assets/images/user.svg',
      width: isTablet ? 60 : 40,
      height: isTablet ? 60 : 40,
      colorFilter: const ColorFilter.mode(Color(0xFF708240), BlendMode.srcIn),
    );
  }

  // --- ДІАЛОГ РЕДАГУВАННЯ ПРОФІЛЮ ---
  // ... всередині класу _ProfileScreenState

  // --- ДІАЛОГ РЕДАГУВАННЯ ПРОФІЛЮ ---
  void _showEditProfileDialog(BuildContext context, ProfileViewModel vm) {
    final nameController = TextEditingController(text: vm.userName);
    // Контролер для фото, початкове значення - поточний URL
    final photoController = TextEditingController(text: vm.photoUrl ?? '');

    showDialog(
      context: context,
      barrierDismissible: false, // Забороняємо закривати кліком повз вікно, поки йде завантаження
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFFFBF0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Edit Profile',
                  style: TextStyle(color: Color(0xFF4B572B), fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- БЛОК ВИБОРУ ФОТО ---
                    GestureDetector(
                      onTap: () async {
                        // 1. Викликаємо метод ViewModel для завантаження в Supabase
                        String? newUrl = await vm.pickImage(context);

                        // 2. Якщо отримали URL, оновлюємо контролер і прев'ю
                        if (newUrl != null) {
                          setStateDialog(() {
                            photoController.text = newUrl;
                          });
                        }
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF708240), width: 2),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: photoController.text.isNotEmpty
                                  ? Image.network(
                                photoController.text,
                                fit: BoxFit.cover,
                                // Додаємо лоадер для самої картинки
                                loadingBuilder: (ctx, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                },
                                errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 50, color: Colors.grey),
                              )
                                  : const Icon(Icons.person, size: 50, color: Colors.grey),
                            ),
                          ),
                          // Іконка камери
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4B572B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tap to change photo",
                      style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 12),
                    ),
                    const SizedBox(height: 20),

                    // --- ПОЛЯ ВВОДУ ---
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Color(0xFF4B572B)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF4B572B))),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                // --- КНОПКА CANCEL (З ЕФЕКТОМ) ---
                TextButton(
                  // foregroundColor робить текст І ефект натискання помаранчевим
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFDF6149),
                  ),
                  onPressed: vm.isLoading ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                // --- КНОПКА SAVE (З ЕФЕКТОМ) ---
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFABBA72),
                    foregroundColor: Colors.white, // Білий текст і біла хвиля при натисканні
                    disabledBackgroundColor: const Color(0xFFABBA72).withOpacity(0.6),
                  ),
                  onPressed: vm.isLoading
                      ? null
                      : () {
                    vm.updateUserProfile(
                      context,
                      newName: nameController.text.trim(),
                      newPhotoUrl: photoController.text,
                    );
                  },
                  child: vm.isLoading
                      ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- КАРТКА СТАТИСТИКИ (без змін) ---
  Widget _buildStatisticsCard(BuildContext context, ProfileViewModel vm, bool isTablet) {
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
                  fontSize: isTablet ? 24 : 20,
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
                  fontSize: isTablet ? 18 : 16,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${vm.calorieGoal} kcal',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: isTablet ? 18 : 16,
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
                  fontSize: isTablet ? 16 : 14,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Last Week',
                style: TextStyle(
                  color: const Color(0xFF6C5206),
                  fontSize: isTablet ? 16 : 14,
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
          backgroundColor: bgCream,
          title: Text('Set Daily Goal', style: TextStyle(color: primaryGreen)),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Calories (kcal)', border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: accentOrange), // Помаранчевий ефект
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: lightGreen,
                foregroundColor: Colors.white, // Білий ефект
              ),
              onPressed: () {
                vm.updateCalorieGoal(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // --- КАРТКА НАЛАШТУВАНЬ (з навігацією) ---
  Widget _buildSettingsCard(BuildContext context, ProfileViewModel vm, bool isTablet) {
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
              color: primaryGreen,
              fontSize: isTablet ? 26 : 22,
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
            showSwitch: true,
          ),
          const Divider(indent: 1, height: 1, color: Colors.black12),
          _buildSettingsRow(
            vm: vm,
            isTablet: isTablet,
            iconAsset: 'assets/images/lock.svg',
            text: 'Privacy',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => PrivacyScreen(viewModel: vm)));
            },
          ),
          const Divider(indent: 1, height: 1, color: Colors.black12),
          _buildSettingsRow(
            vm: vm,
            isTablet: isTablet,
            iconAsset: 'assets/images/help.svg',
            text: 'Help & Support',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const HelpSupportScreen()));
            },
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
    bool showSwitch = false,
    VoidCallback? onTap,
  }) {
    final double fontSize = isTablet ? 18 : 16;
    final double iconSize = isTablet ? 28 : 24;

    return InkWell(
      onTap: onTap,
      child: Padding(
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
                  colorFilter: ColorFilter.mode(primaryGreen, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: isTablet ? 20 : 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: primaryGreen,
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
                      activeTrackColor: accentOrange,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade400,
                    )
                ),
              )
            else
              Icon(Icons.arrow_forward_ios, size: 16, color: primaryGreen.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}

// --- PRIVACY SCREEN ---
class PrivacyScreen extends StatelessWidget {
  final ProfileViewModel viewModel;
  const PrivacyScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      appBar: AppBar(
        title: const Text('Privacy & Security', style: TextStyle(color: Color(0xFF4B572B), fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4B572B)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildOptionTile(
              context,
              title: 'Change Email',
              subtitle: viewModel.userEmail,
              icon: Icons.email_outlined,
              onTap: () => _showChangeEmailDialog(context),
            ),
            const SizedBox(height: 16),
            _buildOptionTile(
              context,
              title: 'Change Password',
              subtitle: 'Last changed: recently',
              icon: Icons.lock_outline,
              onTap: () => _showChangePasswordDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: const Color(0x20ABBA72), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: const Color(0xFF4B572B)),
        ),
        title: Text(title, style: const TextStyle(color: Color(0xFF4B572B), fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showChangeEmailDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        title: const Text('Update Email', style: TextStyle(color: Color(0xFF4B572B))),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'New Email Address', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(foregroundColor: const Color(0xFFDF6149)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFABBA72),
              foregroundColor: Colors.white,
            ),
            onPressed: () => viewModel.updateEmail(context, controller.text),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        title: const Text('Update Password', style: TextStyle(color: Color(0xFF4B572B))),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'New Password', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(foregroundColor: const Color(0xFFDF6149)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFABBA72),
              foregroundColor: Colors.white,
            ),
            onPressed: () => viewModel.updatePassword(context, controller.text),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

// --- HELP & SUPPORT SCREEN ---
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      appBar: AppBar(
        title: const Text('Help & Support', style: TextStyle(color: Color(0xFF4B572B), fontFamily: 'Kantumruy Pro', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4B572B)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/help.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(Color(0xFFABBA72), BlendMode.srcIn),
            ),
            const SizedBox(height: 20),
            const Text(
              'How can we help you?',
              style: TextStyle(color: Color(0xFF4B572B), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Contact our support team at support@example.com for assistance with your account or app features.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}