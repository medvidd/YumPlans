import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/sign_up_vm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF708240),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 412,
                      height: 892,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: const Color(0xFF708240)),
                      child: Stack(
                        children: [
                          Positioned(
                            left: -234,
                            top: 334,
                            child: Container(
                              width: 621,
                              height: 619,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFBF0),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 104,
                            top: -14,
                            child: Container(
                              width: 200,
                              height: 200,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: SvgPicture.asset('assets/images/logo_yp.svg'),
                            ),
                          ),
                          Positioned(
                            left: 22,
                            top: 174,
                            child: Container(
                              width: 367,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 27),
                                    decoration: ShapeDecoration(
                                      color: const Color(0x4CE7FCB1),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xB2708240),
                                        ),
                                        borderRadius: BorderRadius.circular(27),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x440D240B),
                                          blurRadius: 17.10,
                                          offset: Offset(0, 6),
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
                                                fontSize: 16,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF7F7F7),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0x59DF6149),
                                                  ),
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/user.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(width: 18),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: vm.nameController,
                                                      style: const TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 15,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: 'enter your full name ',
                                                        hintStyle: TextStyle(
                                                          color: const Color(0xFF959595),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        suffixText: '*',
                                                        suffixStyle: TextStyle(
                                                          color: const Color(0xFF981800),
                                                          fontSize: 15,
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
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: const Color(0xFF323C15),
                                                fontSize: 16,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF7F7F7),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0x59DF6149),
                                                  ),
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/mail.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(width: 18),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: vm.emailController,
                                                      style: const TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 15,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: '@gmail.com ',
                                                        hintStyle: TextStyle(
                                                          color: const Color(0xFF959595),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        suffixText: '*',
                                                        suffixStyle: TextStyle(
                                                          color: const Color(0xFF981800),
                                                          fontSize: 15,
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
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                color: const Color(0xFF323C15),
                                                fontSize: 16,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF7F7F7),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0x59DF6149),
                                                  ),
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/lock.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(width: 18),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: vm.passwordController,
                                                      obscureText: vm.obscurePassword,
                                                      style: const TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 15,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: 'enter a password ',
                                                        hintStyle: TextStyle(
                                                          color: const Color(0xFF959595),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        suffixText: '*',
                                                        suffixStyle: TextStyle(
                                                          color: const Color(0xFF981800),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.zero,
                                                        isDense: true,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 18),
                                                  GestureDetector(
                                                    onTap: vm.toggleObscurePassword,
                                                    child: SvgPicture.asset(
                                                      vm.obscurePassword ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                                      width: 22,
                                                      height: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'use 8+ characters with a mix of letters and numbers ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Confirm Password',
                                              style: TextStyle(
                                                color: const Color(0xFF323C15),
                                                fontSize: 16,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFF7F7F7),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0x59DF6149),
                                                  ),
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/lock.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(width: 18),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: vm.confirmPasswordController,
                                                      obscureText: vm.obscureConfirmPassword,
                                                      style: const TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontSize: 15,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: 'enter a password ',
                                                        hintStyle: TextStyle(
                                                          color: const Color(0xFF959595),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        suffixText: '*',
                                                        suffixStyle: TextStyle(
                                                          color: const Color(0xFF981800),
                                                          fontSize: 15,
                                                          fontFamily: 'Kantumruy Pro',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.zero,
                                                        isDense: true,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 18),
                                                  GestureDetector(
                                                    onTap: vm.toggleObscureConfirmPassword,
                                                    child: SvgPicture.asset(
                                                      vm.obscureConfirmPassword ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                                      width: 22,
                                                      height: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: vm.isChecked,
                                              onChanged: (bool? value) {
                                                vm.toggleChecked(value ?? false);
                                              },
                                              side: BorderSide(
                                                width: 2,
                                                color: const Color(0xFFABBA72),
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
                                                        fontSize: 14,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Terms and Privacy',
                                                      style: TextStyle(
                                                        color: const Color(0xFF708240),
                                                        fontSize: 14,
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
                                                        fontSize: 14,
                                                        fontFamily: 'Kantumruy Pro',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '*',
                                                      style: TextStyle(
                                                        color: const Color(0xFF981800),
                                                        fontSize: 14,
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
                                        SizedBox(height: 16),
                                        GestureDetector(
                                          onTap: () => vm.createAccount(context),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                                                  fontSize: 16,
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
                                  SizedBox(height: 34),
                                  SizedBox(
                                    width: 367,
                                    height: 25,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Already have an account? ',
                                            style: TextStyle(
                                              color: const Color(0xFF708240),
                                              fontSize: 15,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Sign In',
                                            style: TextStyle(
                                              color: const Color(0xFFDF6149),
                                              fontSize: 15,
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