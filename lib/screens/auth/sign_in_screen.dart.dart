import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFA8072), // Salmon color
      body: Stack(
        children: [
          // Content Layer (Sign In Text)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WaveClipperOne(reverse: true),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.60,
                width: double.infinity,
                color: Colors.white,
                // Wave thakar karone text-ke ektu niche namate hobe
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: const [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}