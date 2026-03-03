import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  // লগআউট ফাংশন
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // যেহেতু main.dart-এ StreamBuilder আছে, তাই signOut করার সাথে সাথে
      // অ্যাপ অটোমেটিক লগইন স্ক্রিনে চলে যাবে। আলাদা করে Navigator দরকার নেই।
    } catch (e) {
      debugPrint("Logout Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryCoral,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // একটি কনফার্মেশন ডায়ালগ দেখানো ভালো
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _logout();
                      },
                      child: const Text("Yes", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home_outlined, size: 80, color: AppColors.primaryCoral),
              const SizedBox(height: 10),
              Text(
                "Welcome to Home!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              ),
              const SizedBox(height: 5),
              Text(
                "User: ${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}