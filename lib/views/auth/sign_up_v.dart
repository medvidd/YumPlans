import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/sign_up_vm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.04,
                        left: screenWidth * 0.053,
                        right: screenWidth * 0.053,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.49,
                            height: screenWidth * 0.45,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: SvgPicture.asset('assets/images/logo_yp.svg'),
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.046, vertical: screenHeight * 0.02),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        color: const Color(0xFF323C15),
                                        fontSize: screenWidth * 0.039,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.00185),
                                    Container(
                                      height: screenWidth * 0.121,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.027, vertical: screenHeight * 0.011),
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
                                          SvgPicture.asset(
                                            'assets/images/user.svg',
                                            width: screenWidth * 0.049,
                                            height: screenWidth * 0.049,
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          Expanded(
                                            child: TextField(
                                              controller: vm.nameController,
                                              style: TextStyle(
                                                color: const Color(0xFF000000),
                                                fontSize: screenWidth * 0.036,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'enter your full name ',
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF959595),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                suffixText: '*',
                                                suffixStyle: TextStyle(
                                                  color: const Color(0xFF981800),
                                                  fontSize: screenWidth * 0.036,
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
                                    SizedBox(height: screenHeight * 0.018),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: const Color(0xFF323C15),
                                        fontSize: screenWidth * 0.039,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.00185),
                                    Container(
                                      height: screenWidth * 0.121,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.027, vertical: screenHeight * 0.011),
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
                                          SvgPicture.asset(
                                            'assets/images/mail.svg',
                                            width: screenWidth * 0.049,
                                            height: screenWidth * 0.049,
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          Expanded(
                                            child: TextField(
                                              controller: vm.emailController,
                                              style: TextStyle(
                                                color: const Color(0xFF000000),
                                                fontSize: screenWidth * 0.036,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: '@gmail.com ',
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF959595),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                suffixText: '*',
                                                suffixStyle: TextStyle(
                                                  color: const Color(0xFF981800),
                                                  fontSize: screenWidth * 0.036,
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
                                    SizedBox(height: screenHeight * 0.018),
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                        color: const Color(0xFF323C15),
                                        fontSize: screenWidth * 0.039,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.00185),
                                    Container(
                                      height: screenWidth * 0.121,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.027, vertical: screenHeight * 0.011),
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
                                          SvgPicture.asset(
                                            'assets/images/lock.svg',
                                            width: screenWidth * 0.049,
                                            height: screenWidth * 0.049,
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          Expanded(
                                            child: TextField(
                                              controller: vm.passwordController,
                                              obscureText: vm.obscurePassword,
                                              style: TextStyle(
                                                color: const Color(0xFF000000),
                                                fontSize: screenWidth * 0.036,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'enter your password ',
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF959595),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                suffixText: '*',
                                                suffixStyle: TextStyle(
                                                  color: const Color(0xFF981800),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          GestureDetector(
                                            onTap: vm.toggleObscurePassword,
                                            child: Container(
                                              width: screenWidth * 0.053,
                                              height: screenWidth * 0.049,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: SvgPicture.asset(
                                                vm.obscurePassword ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.018),
                                    Text(
                                      'Confirm Password',
                                      style: TextStyle(
                                        color: const Color(0xFF323C15),
                                        fontSize: screenWidth * 0.039,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.00185),
                                    Container(
                                      height: screenWidth * 0.121,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.027, vertical: screenHeight * 0.011),
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
                                          SvgPicture.asset(
                                            'assets/images/lock.svg',
                                            width: screenWidth * 0.049,
                                            height: screenWidth * 0.049,
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          Expanded(
                                            child: TextField(
                                              controller: vm.confirmPasswordController,
                                              obscureText: vm.obscureConfirmPassword,
                                              style: TextStyle(
                                                color: const Color(0xFF000000),
                                                fontSize: screenWidth * 0.036,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'confirm your password ',
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF959595),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                suffixText: '*',
                                                suffixStyle: TextStyle(
                                                  color: const Color(0xFF981800),
                                                  fontSize: screenWidth * 0.036,
                                                  fontFamily: 'Kantumruy Pro',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.044),
                                          GestureDetector(
                                            onTap: vm.toggleObscureConfirmPassword,
                                            child: Container(
                                              width: screenWidth * 0.053,
                                              height: screenWidth * 0.049,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: SvgPicture.asset(
                                                vm.obscureConfirmPassword ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.018),
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
                                                    fontSize: screenWidth * 0.034,
                                                    fontFamily: 'Kantumruy Pro',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Terms and Privacy',
                                                  style: TextStyle(
                                                    color: const Color(0xFF708240),
                                                    fontSize: screenWidth * 0.034,
                                                    fontFamily: 'Kantumruy Pro',
                                                    fontWeight: FontWeight.w400,
                                                    decoration: TextDecoration.underline,
                                                    decorationColor: const Color(0xFF708240),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: TextStyle(
                                                    color: const Color(0xFF708240),
                                                    fontSize: screenWidth * 0.034,
                                                    fontFamily: 'Kantumruy Pro',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '*',
                                                  style: TextStyle(
                                                    color: const Color(0xFF981800),
                                                    fontSize: screenWidth * 0.034,
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
                                    SizedBox(height: screenHeight * 0.018),
                                    GestureDetector(
                                      onTap: () => vm.createAccount(context),
                                      child: Container(
                                        width: double.infinity,
                                        height: screenWidth * 0.121,
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.029, vertical: screenHeight * 0.011),
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
                                              fontSize: screenWidth * 0.039,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.038),
                          SizedBox(
                            width: double.infinity,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: TextStyle(
                                      color: const Color(0xFF708240),
                                      fontSize: screenWidth * 0.036,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: const Color(0xFFDF6149),
                                      fontSize: screenWidth * 0.036,
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
                          ),
                        ],
                      ),
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