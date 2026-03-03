// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:login/core/constants/app_colors.dart';
// import 'package:login/core/constants/app_routes.dart';
// import 'package:login/core/constants/app_styles.dart';
// import 'package:login/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../providers/auth_provider.dart';
//
// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//   static String routeName = "/signin";
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isObscured = true;
//   bool _rememberMe = false;
//
//   void _handleSignIn() {
//     if (_formKey.currentState!.validate()) {
//       print("Login Logic Here");
//       final authProvider = context.read<auth_Provider>();
//       try{
//         authProvider.login(_emailController.text.trim(), _passwordController.text.trim());
//         if(mounted){
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfully")));
//         }
//
//         Navigator.pushNamedAndRemoveUntil(context, AppRoute.home, (predicate)=> false);
//
//
//       }catch (e){
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed!!!")));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFA8072), // primaryCoral এর মতো কালার
//       body: SingleChildScrollView( // পুরো স্ক্রিন স্ক্রলযোগ্য করা হয়েছে
//         child: Column(
//           children: [
//             // উপরের ফাঁকা অংশ (যদি ওয়েভ ইফেক্ট উপরে রাখতে চান)
//             SizedBox(height: MediaQuery.of(context).size.height * 0.25),
//
//             ClipPath(
//               clipper: WaveClipperOne(reverse: true),
//               child: Container(
//                 width: double.infinity,
//                 color: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // --- Title Section ---
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Sign In",
//                               style: AppStyles.headingStyle.copyWith(
//                                 color: Colors.black,
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: AppColors.primaryCoral,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       // Email Field
//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: AppStyles.textFieldDecoration.copyWith(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryCoral),
//                           hintText: "demo@email.com",
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) return "Email is required";
//                           if (!value.contains("@")) return "Invalid email format";
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       // Password Field
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: _isObscured,
//                         decoration: AppStyles.textFieldDecoration.copyWith(
//                           labelText: "Password",
//                           prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryCoral),
//                           hintText: "Enter your password",
//                           suffixIcon: IconButton(
//                             icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
//                             onPressed: () => setState(() => _isObscured = !_isObscured),
//                           ),
//                         ),
//                         validator: (value) => (value == null || value.length < 6) ? "Min 6 chars" : null,
//                       ),
//
//                       const SizedBox(height: 15),
//
//                       // --- Remember Me & Forgot Password ---
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: _rememberMe,
//                                 activeColor: AppColors.primaryCoral,
//                                 onChanged: (value) => setState(() => _rememberMe = value!),
//                               ),
//                               const Text("Remember Me", style: TextStyle(color: Colors.grey)),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text("Forgot Password?", style: TextStyle(color: AppColors.primaryCoral, fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 25),
//
//                       // --- Login Button ---
//                       SizedBox(
//                         width: double.infinity,
//                         height: 55,
//                         child: ElevatedButton(
//                           onPressed: _handleSignIn,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryCoral,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                           ),
//                           child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//
//                       const SizedBox(height: 25),
//
//                       // --- SignUp Link ---
//                       Center(
//                         child: RichText(
//                           text: TextSpan(
//                             children: [
//                               const TextSpan(text: "Don't have an Account ? ", style: TextStyle(color: Colors.grey, fontSize: 16)),
//                               TextSpan(
//                                 text: "SignUp",
//                                 style: const TextStyle(color: AppColors.primaryCoral, fontWeight: FontWeight.bold),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.pushNamed(context, AppRoute.signUp);
//                                   },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:login/core/constants/app_colors.dart';
import 'package:login/core/constants/app_routes.dart';
import 'package:login/core/constants/app_styles.dart';
import 'package:login/providers/auth_provider.dart'; // নিশ্চিত করুন এই পাথটি সঠিক
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String routeName = "/signin";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscured = true;
  bool _rememberMe = false;
  bool _isLoading = false; // লোডিং স্টেট দেখানোর জন্য

  @override
  void dispose() {
    // মেমরি লিক রোধ করতে কন্ট্রোলারগুলো ডিসপোজ করা জরুরি
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = context.read<auth_Provider>(); // Class name PascalCase হওয়া উচিত

      try {
        // ইমেইল ও পাসওয়ার্ড দিয়ে লগইন ট্রাই করা
        await authProvider.login(
            _emailController.text.trim(),
            _passwordController.text.trim()
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successfully"), backgroundColor: Colors.green),
          );

          // সফল হলে হোম স্ক্রিনে নেভিগেট করা এবং স্ট্যাক ক্লিয়ার করা
          Navigator.pushNamedAndRemoveUntil(context, AppRoute.home, (route) => false);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Failed: ${e.toString()}"), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryCoral, // ব্যাকগ্রাউন্ড কালার
      body: SingleChildScrollView(
        child: Column(
          children: [
            // উপরের ডিজাইন অংশ
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),

            ClipPath(
              clipper: WaveClipperOne(reverse: true),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Sign In",
                        style: AppStyles.headingStyle.copyWith(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryCoral,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppStyles.textFieldDecoration.copyWith(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryCoral),
                          hintText: "demo@email.com",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Email is required";
                          if (!value.contains("@")) return "Invalid email format";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscured,
                        decoration: AppStyles.textFieldDecoration.copyWith(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryCoral),
                          hintText: "Enter your password",
                          suffixIcon: IconButton(
                            icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _isObscured = !_isObscured),
                          ),
                        ),
                        validator: (value) => (value == null || value.length < 6) ? "Min 6 chars" : null,
                      ),

                      const SizedBox(height: 15),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                activeColor: AppColors.primaryCoral,
                                onChanged: (value) => setState(() => _rememberMe = value!),
                              ),
                              const Text("Remember Me", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.forgetpass);
                            },
                            child: const Text("Forgot Password?", style: TextStyle(color: AppColors.primaryCoral, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryCoral,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // SignUp Link
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: "Don't have an Account ? ", style: TextStyle(color: Colors.grey, fontSize: 16)),
                              TextSpan(
                                text: "SignUp",
                                style: const TextStyle(color: AppColors.primaryCoral, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, AppRoute.signUp);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50), // নিচের স্পেস
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}