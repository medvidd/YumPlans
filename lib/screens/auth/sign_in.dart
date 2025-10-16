import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDF6149),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 412,
                  height: 892,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: const Color(0xFFDF6149)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 11,
                        top: 334,
                        child: Container(
                          width: 621,
                          height: 628,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFBF0),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: -8,
                        child: Container(
                          width: 300,
                          height: 300,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: SvgPicture.asset('assets/images/logo_yp.svg'),
                        ),
                      ),
                      Positioned(
                        left: 23,
                        top: 267,
                        child: Container(
                          width: 367,
                          height: 502,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 34,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Sign in ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 305,
                                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 27),
                                decoration: ShapeDecoration(
                                  color: const Color(0x7FFFE0D4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0x59DF6149),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 28,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 32,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: null,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              spacing: 16,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 329,
                                                        child: Text(
                                                          'Email',
                                                          style: TextStyle(
                                                            color: const Color(0xFF981800),
                                                            fontSize: 16,
                                                            fontFamily: 'KantumruyPro',
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
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
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 18,
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                spacing: 18,
                                                                children: [
                                                                  Container(
                                                                    width: 20,
                                                                    height: 20,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: SvgPicture.asset('assets/images/mail.svg'),
                                                                  ),
                                                                  SizedBox(
                                                                    child: Text.rich(
                                                                      TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: '@gmail.com ',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF959595),
                                                                              fontSize: 15,
                                                                              fontFamily: 'Kantumruy Pro',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text: '*',
                                                                            style: TextStyle(
                                                                              color: const Color(0xFF981800),
                                                                              fontSize: 15,
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
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          'Password',
                                                          style: TextStyle(
                                                            color: const Color(0xFF981800),
                                                            fontSize: 16,
                                                            fontFamily: 'Kantumruy Pro',
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
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
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 18,
                                                          children: [
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              spacing: 18,
                                                              children: [
                                                                Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: SvgPicture.asset('assets/images/lock.svg'),
                                                                ),
                                                                Text.rich(
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: 'enter your password ',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF959595),
                                                                          fontSize: 15,
                                                                          fontFamily: 'Kantumruy Pro',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: '*',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF981800),
                                                                          fontSize: 15,
                                                                          fontFamily: 'Kantumruy Pro',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: 22,
                                                              height: 20,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: BoxDecoration(),
                                                              child: SvgPicture.asset('assets/images/eye_off.svg'),
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
                                          Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                                              spacing: 18,
                                              children: [
                                                Text(
                                                  'SIGN IN',
                                                  style: TextStyle(
                                                    color: const Color(0xFF4B572B),
                                                    fontSize: 16,
                                                    fontFamily: 'Kantumruy Pro',
                                                    fontWeight: FontWeight.w700,
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
                              SizedBox(
                                width: 367,
                                height: 25,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don’t have an account? ',
                                        style: TextStyle(
                                          color: const Color(0xFFDF6149),
                                          fontSize: 15,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Sign up',
                                        style: TextStyle(
                                          color: const Color(0xFF708240),
                                          fontSize: 15,
                                          fontFamily: 'Kantumruy Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
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
                )
              ],
            ),
        ),
      ),
    );
  }
}