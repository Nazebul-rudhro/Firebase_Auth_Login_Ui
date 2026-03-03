import 'package:flutter/material.dart';
import '../../screens/auth/forget_password_screen.dart';
import '../../screens/auth/sign_in_screen.dart.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/welcome/welcome_screen.dart';

class AppRoute {
  static const String welcome = '/welcome'; // '/' এর বদলে '/welcome' দিন
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String forgetpass = '/forget';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      welcome: (context) => const WelcomeScreen(),
      signIn: (context) => const SignIn(),
      signUp: (context) => const SignupScreen(),
      forgetpass: (context) => const ForgetPasswordScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}