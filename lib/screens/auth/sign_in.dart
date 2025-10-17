import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sign_up.dart';
import '/screens/home/home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscure = true;
  late TapGestureRecognizer _signUpRecognizer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      };
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

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
                      right: -234,
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
                      child: SizedBox(
                        width: 367,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(height: 34),
                            Container(
                              width: double.infinity,
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
                                              fontSize: 16,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(height: 16),
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: SvgPicture.asset('assets/images/mail.svg'),
                                                ),
                                                const SizedBox(width: 18),
                                                Expanded(
                                                  child: TextField(
                                                    controller: _emailController,
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
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 32),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Password',
                                            style: TextStyle(
                                              color: const Color(0xFF981800),
                                              fontSize: 16,
                                              fontFamily: 'Kantumruy Pro',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(height: 16),
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: SvgPicture.asset('assets/images/lock.svg'),
                                                ),
                                                const SizedBox(width: 18),
                                                Expanded(
                                                  child: TextField(
                                                    controller: _passwordController,
                                                    obscureText: _obscure,
                                                    style: const TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 15,
                                                      fontFamily: 'Kantumruy Pro',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    decoration: InputDecoration(
                                                      hintText: 'enter your password ',
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
                                                const SizedBox(width: 18),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _obscure = !_obscure;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 22,
                                                    height: 20,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: SvgPicture.asset(
                                                      _obscure ? 'assets/images/eye_off.svg' : 'assets/images/eye_on.svg',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 32),
                                      GestureDetector(
                                        onTap: () {
                                          if (_emailController.text.isNotEmpty &&
                                              _passwordController.text.isNotEmpty) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => const HomePage()),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Please fill all fields')),
                                            );
                                          }
                                        },
                                        child: Container(
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
                                      ),
                                    ],
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
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(0xFF708240),
                                      ),
                                      recognizer: _signUpRecognizer,
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