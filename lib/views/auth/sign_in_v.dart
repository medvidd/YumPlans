import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/sign_in_vm.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFDF6149),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: -screenWidth * 0.57,
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
                        left: screenWidth * 0.056,
                        right: screenWidth * 0.056,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.73,
                            height: screenWidth * 0.60,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: SvgPicture.asset('assets/images/logo_yp.svg'),
                          ),
                          SizedBox(
                            child: Text(
                              'Sign in ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.06,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.038),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.046, vertical: screenHeight * 0.030),
                            decoration: ShapeDecoration(
                              color: const Color(0x7FFFE0D4),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0x59DF6149),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            color: const Color(0xFF981800),
                                            fontSize: screenWidth * 0.039,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.00185),
                                        Container(
                                          width: double.infinity,
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.048,
                                                height: screenWidth * 0.048,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(),
                                                child: SvgPicture.asset('assets/images/mail.svg'),
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
                                            color: const Color(0xFF981800),
                                            fontSize: screenWidth * 0.039,
                                            fontFamily: 'Kantumruy Pro',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.00185),
                                        Container(
                                          width: double.infinity,
                                          height: screenWidth * 0.121,
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.029, vertical: screenHeight * 0.011),
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.048,
                                                height: screenWidth * 0.048,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(),
                                                child: SvgPicture.asset('assets/images/lock.svg'),
                                              ),
                                              SizedBox(width: screenWidth * 0.044),
                                              Expanded(
                                                child: TextField(
                                                  controller: vm.passwordController,
                                                  obscureText: vm.obscure,
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
                                                onTap: vm.toggleObscure,
                                                child: Container(
                                                  width: screenWidth * 0.053,
                                                  height: screenWidth * 0.049,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: const BoxDecoration(),
                                                  child: SvgPicture.asset(
                                                    vm.obscure ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.036),
                                    GestureDetector(
                                      onTap: () => vm.signIn(context),
                                      child: Container(
                                        width: double.infinity,
                                        height: screenWidth * 0.121,
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.029, vertical: screenHeight * 0.011),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFABBA72),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'SIGN IN',
                                              style: TextStyle(
                                                color: const Color(0xFF4B572B),
                                                fontSize: screenWidth * 0.039,
                                                fontFamily: 'Kantumruy Pro',
                                                fontWeight: FontWeight.w700,
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
                          SizedBox(height: screenHeight * 0.038),
                          SizedBox(
                            width: double.infinity,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account? ',
                                    style: TextStyle(
                                      color: const Color(0xFFDF6149),
                                      fontSize: screenWidth * 0.036,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: const Color(0xFF708240),
                                      fontSize: screenWidth * 0.036,
                                      fontFamily: 'Kantumruy Pro',
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xFF708240),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => vm.navigateToSignUp(context),
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