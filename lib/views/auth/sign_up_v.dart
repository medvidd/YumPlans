import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '/viewmodels/sign_up_vm.dart';
import '/widgets/loading_w.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 700.0;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > SignUpScreen.kTabletBreakpoint;

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
                if (vm.isLoading)
                  const LoadingWidget(),
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
        constraints: BoxConstraints(maxWidth: SignUpScreen.kMaxContentWidth),
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
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        TextFormField(
                          controller: vm.nameController,
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: fieldFontSize,
                          ),
                          decoration: _buildInputDecoration(
                              hint: 'enter your full name',
                              iconAsset: 'assets/images/user.svg',
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
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        Text(
                          'Email',
                          style: TextStyle(
                            color: const Color(0xFF323C15),
                            fontSize: labelFontSize,
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
                            color: const Color(0xFF323C15),
                            fontSize: labelFontSize,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: vm.passwordController,
                          obscureText: vm.obscurePassword,
                          decoration: _buildInputDecoration(
                            hint: 'enter your password',
                            iconAsset: 'assets/images/lock.svg',
                            fontSize: fieldFontSize,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: GestureDetector(
                                onTap: vm.toggleObscurePassword,
                                child: SvgPicture.asset(
                                  vm.obscurePassword
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
                            if (value.length < 8) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: const Color(0xFF323C15),
                            fontSize: labelFontSize,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: vm.confirmPasswordController,
                          obscureText: vm.obscureConfirmPassword,
                          decoration: _buildInputDecoration(
                            hint: 'confirm your password',
                            iconAsset: 'assets/images/lock.svg',
                            fontSize: fieldFontSize,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: GestureDetector(
                                onTap: vm.toggleObscureConfirmPassword,
                                child: SvgPicture.asset(
                                  vm.obscureConfirmPassword
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
                              return 'Please confirm your password';
                            }
                            if (value != vm.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
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
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (!vm.isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please agree to terms'))
                                );
                                return;
                              }
                              vm.createAccount(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
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
          color: Color(0xFF708240),
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