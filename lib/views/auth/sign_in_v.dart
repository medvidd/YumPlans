import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '/viewmodels/sign_in_vm.dart';
import '/widgets/loading_w.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 700.0;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > SignInScreen.kTabletBreakpoint;

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
                  child: _buildContent(context, vm, isTablet),
                ),
                if (vm.isLoading)
                  const LoadingWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SignInViewModel vm, bool isTablet) {

    final double logoHeight = isTablet ? 300 : 180;
    final double titleFontSize = isTablet ? 34 : 28;
    final double labelFontSize = isTablet ? 18 : 16;
    final double fieldFontSize = isTablet ? 17 : 15;
    final double buttonFontSize = isTablet ? 18 : 16;
    final double bottomTextFontSize = isTablet ? 17 : 15;
    final double verticalPadding = isTablet ? 90 : 40;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: SignInScreen.kMaxContentWidth),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: verticalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: logoHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset('assets/images/logo_yp.svg'),
                ),
                Text(
                  'Sign in ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            color: const Color(0xFF981800),
                            fontSize: labelFontSize,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: vm.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: fieldFontSize,
                          ),
                          decoration: _buildInputDecoration(
                              hint: '@gmail.com',
                              iconAsset: 'assets/images/mail.svg',
                              fontSize: fieldFontSize
                          ).copyWith(
                              suffix: const Text(
                                '*',
                                style: TextStyle(
                                  color: Color(0xFF981800),
                                ),
                              )
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._+-]')),
                          ],

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email format';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Password',
                          style: TextStyle(
                            color: const Color(0xFF981800),
                            fontSize: labelFontSize,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: vm.passwordController,
                          obscureText: vm.obscure,
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: fieldFontSize,
                          ),
                          decoration: _buildInputDecoration(
                            hint: 'enter your password',
                            iconAsset: 'assets/images/lock.svg',
                            fontSize: fieldFontSize,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: GestureDetector(
                                onTap: vm.toggleObscure,
                                child: SvgPicture.asset(
                                  vm.obscure
                                      ? 'assets/images/eye_off.svg'
                                      : 'assets/images/eye_on.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              vm.signIn(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFABBA72),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: const Color(0xFF4B572B),
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
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: const Color(0xFFDF6149),
                          fontSize: bottomTextFontSize,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: const Color(0xFF708240),
                          fontSize: bottomTextFontSize,
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
              ],
            ),
          ),
        ),
      ),
    );
  }


  InputDecoration _buildInputDecoration({
    required String hint,
    required String iconAsset,
    required double fontSize,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SvgPicture.asset(iconAsset, width: 22, height: 22),
      ),
      hintText: '$hint ',
      hintStyle: TextStyle(
        color: const Color(0xFF959595),
        fontSize: fontSize,
        fontFamily: 'Kantumruy Pro',
        fontWeight: FontWeight.w400,
      ),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 48,
        minHeight: 22,
        maxWidth: 48,
        maxHeight: 22,
      ),
      filled: true,
      fillColor: const Color(0xFFF7F7F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: Color(0x59DF6149),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: Color(0x59DF6149),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0xFFDF6149),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.red,
        ),
      ),
    );
  }
}