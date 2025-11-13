import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/fb_services/auth_service.dart';
import '/views/home_page.dart';
import '/views/auth/sign_up_v.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SignInViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  String? errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final AuthService _authService = AuthService();

  void toggleObscure() {
    obscure = !obscure;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    _setLoading(true);

    try {
      await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseAnalytics.instance.logLogin(loginMethod: 'email');

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageScreen()),
      );

    } on FirebaseAuthException catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
          e,
          stackTrace,
          reason: 'A user failed to sign in',
          fatal: false
      );

      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        errorMessage = 'Invalid email or password.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password.';
      } else {
        errorMessage = 'An error occurred. Please try again later.';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      errorMessage = 'An unknown error occurred.';
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red),
        );
      }
    }

    _setLoading(false);
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}