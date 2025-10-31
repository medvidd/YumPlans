import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/sign_up_vm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 700.0;
  static const double kTextFieldHeight = 49.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF708240),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: -screenWidth * 0.57,
                  top: screenHeight * 0.37,
                  child: Container(
                    width: screenWidth * 1.51,
                    height: screenHeight * 0.69,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFFFBF0),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                SafeArea(
                  child: _buildContent(context, vm, isTablet),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SignUpViewModel vm, bool isTablet) {
    final double logoHeight = isTablet ? 200 : 150;
    final double labelFontSize = isTablet ? 18 : 16;
    final double fieldFontSize = isTablet ? 17 : 15;
    final double checkboxFontSize = isTablet ? 16 : 14;
    final double buttonFontSize = isTablet ? 18 : 16;
    final double bottomTextFontSize = isTablet ? 17 : 15;

    final double verticalPadding = isTablet ? 60 : 30;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: verticalPadding,
            ).add(
              EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: logoHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset('assets/images/logo_yp.svg'),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: ShapeDecoration(
                    color: const Color(0x4CE7FCB1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xB2708240),
                      ),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x440D240B),
                        blurRadius: 17.10,
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: const Color(0xFF323C15),
                          fontSize: labelFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: kTextFieldHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/user.svg', width: 22, height: 22),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: vm.nameController,
                                style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontSize: fieldFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'enter your full name ',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF959595),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixText: '*',
                                  suffixStyle: TextStyle(
                                    color: const Color(0xFF981800),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        'Email',
                        style: TextStyle(
                          color: const Color(0xFF323C15),
                          fontSize: labelFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: kTextFieldHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/mail.svg', width: 22, height: 22),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: vm.emailController,
                                style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontSize: fieldFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: '@gmail.com ',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF959595),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixText: '*',
                                  suffixStyle: TextStyle(
                                    color: const Color(0xFF981800),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        'Password',
                        style: TextStyle(
                          color: const Color(0xFF323C15),
                          fontSize: labelFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: kTextFieldHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/lock.svg', width: 22, height: 22),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: vm.passwordController,
                                obscureText: vm.obscurePassword,
                                style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontSize: fieldFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'enter your password ',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF959595),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixText: '*',
                                  suffixStyle: TextStyle(
                                    color: const Color(0xFF981800),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: vm.toggleObscurePassword,
                              child: SvgPicture.asset(
                                vm.obscurePassword
                                    ? 'assets/images/eye_off.svg'
                                    : 'assets/images/eye_on.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: const Color(0xFF323C15),
                          fontSize: labelFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: kTextFieldHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/lock.svg', width: 22, height: 22),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: vm.confirmPasswordController,
                                obscureText: vm.obscureConfirmPassword,
                                style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontSize: fieldFontSize,
                                  fontFamily: 'Kantumruy Pro',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'confirm your password ',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF959595),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixText: '*',
                                  suffixStyle: TextStyle(
                                    color: const Color(0xFF981800),
                                    fontSize: fieldFontSize,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: vm.toggleObscureConfirmPassword,
                              child: SvgPicture.asset(
                                vm.obscureConfirmPassword
                                    ? 'assets/images/eye_off.svg'
                                    : 'assets/images/eye_on.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Checkbox(
                            value: vm.isChecked,
                            onChanged: (bool? value) {
                              vm.toggleChecked(value ?? false);
                            },
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFFABBA72),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            activeColor: const Color(0xFFABBA72),
                            checkColor: Colors.white,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I agree to ',
                                    style: TextStyle(
                                      color: const Color(0xFF708240),
                                      fontSize: checkboxFontSize,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and Privacy',
                                    style: TextStyle(
                                      color: const Color(0xFF708240),
                                      fontSize: checkboxFontSize,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xFF708240),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: const Color(0xFF981800),
                                      fontSize: checkboxFontSize,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      GestureDetector(
                        onTap: () => vm.createAccount(context),
                        child: Container(
                          width: double.infinity,
                          height: kTextFieldHeight,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF49069),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                color: const Color(0xFF9D3B29),
                                fontSize: buttonFontSize,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: const Color(0xFF708240),
                          fontSize: bottomTextFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: const Color(0xFFDF6149),
                          fontSize: bottomTextFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFDF6149),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => vm.navigateToSignIn(context),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}