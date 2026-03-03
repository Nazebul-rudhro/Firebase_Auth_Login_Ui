import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../core/constants/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFA8072),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WaveClipperOne(reverse: true),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Make a splash with this stylish UI.\nModern and artistic touch.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // ERROR FIX: pushAndRemoveUntil er bodle pushNamedAndRemoveUntil hobe
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoute.signIn,
                              (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("Continue", style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: Color(0xFFFA8072),
                            radius: 25,
                            child: Icon(Icons.arrow_forward, color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}