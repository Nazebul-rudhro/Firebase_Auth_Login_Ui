import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/firebase_options.dart';
import 'package:login/providers/auth_provider.dart';
import 'package:login/screens/home/home_screen.dart';
import 'package:login/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        // Make sure your class name is AuthProvider (Standard Dart naming)
        ChangeNotifierProvider(create: (_) => auth_Provider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Login',

      // IMPORTANT: No initialRoute here!
      // StreamBuilder acts as the gateway.
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. While checking Firebase Auth state, show a loader
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // 2. If user is logged in, snapshot.hasData will be true
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // 3. If user is NOT logged in, show the Welcome Screen
          return const WelcomeScreen();
        },
      ),

      // Routes for Navigator.pushNamed to work
      routes: AppRoute.getRoutes(),
    );
  }
}