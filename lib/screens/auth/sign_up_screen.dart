// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:login/core/constants/app_colors.dart';
// import 'package:login/core/constants/app_routes.dart';
// import 'package:login/core/constants/app_styles.dart';
// import 'package:login/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => SignupScreenState();
// }
//
// class SignupScreenState extends State<SignupScreen> {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   bool _isObscured = true;
//   bool _isObscuredOne = true;
//
//
//
//   void _showMessage(String message, {bool isError = false}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(10),
//       ),
//     );
//   }
//
//   // void _onSubmit() async {
//   //   if (_key.currentState!.validate()) {
//   //     // আপনার Provider ক্লাসের নাম auth_Provider হলে এটি ঠিক আছে,
//   //     // নাহলে AuthProvider (ক্যাপিটাল A) দিয়ে চেক করুন।
//   //     final authProvider = context.read<auth_Provider>();
//   //     debugPrint(_emailController.toString());
//   //     debugPrint(_passwordController.toString());
//   //
//   //     try {
//   //       await authProvider.signUp(
//   //         _emailController.text.trim(),
//   //         _passwordController.text.trim(),
//   //       );
//   //
//   //       if (mounted) {
//   //         _showMessage("Account Created Successfully!", isError: false);
//   //         Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (route) => false);
//   //       }
//   //     } catch (e) {
//   //       if (mounted) {
//   //         _showMessage(e.toString(), isError: true);
//   //       }
//   //     }
//   //   }
//   // }
//
//
//   void _onSubmit() async {
//     if (_key.currentState!.validate()) {
//       final authProvider = context.read<auth_Provider>();
//
//       try {
//         await authProvider.signUp(
//           _emailController.text.trim(),
//           _passwordController.text.trim(),
//         );
//
//         if (mounted) {
//           _showMessage("Account Created Successfully!", isError: false);
//           // সফল হলে সরাসরি হোমে বা সাইন-ইন পেজে পাঠান
//           Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (route) => false);
//         }
//       } catch (e) {
//         // এখানে catch এর ভেতর mounted চেক করা জরুরি
//         if (mounted) {
//           _showMessage(e.toString(), isError: true);
//         }
//       }
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // লোডিং স্টেট ওয়াচ করা
//     final isLoading = context.watch<auth_Provider>().isLoading;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ClipPath(
//               clipper: WaveClipperOne(),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.35,
//                 color: AppColors.primaryCoral,
//                 child: const Center(
//                   child: Text(
//                     "Welcome!",
//                     style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               child: Form(
//                 key: _key,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Sign Up", style: AppStyles.headingStyle.copyWith(color: Colors.black, fontSize: 28)),
//                     const SizedBox(height: 25),
//                     TextFormField(
//                       controller: _emailController,
//                       style: AppStyles.bodyStyle,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: AppStyles.textFieldDecoration.copyWith(
//                         labelText: "Email",
//                         prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryCoral),
//                         hintText: 'example@gmail.com',
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) return "Email field is empty!";
//                         if (!v.contains('@')) return "Invalid email format";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: _isObscured,
//                       style: AppStyles.bodyStyle,
//                       decoration: AppStyles.textFieldDecoration.copyWith(
//                         labelText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryCoral),
//                         suffixIcon: IconButton(
//                           icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
//                           onPressed: () => setState(() => _isObscured = !_isObscured),
//                         ),
//                       ),
//                       validator: (v) => (v == null || v.length < 8) ? "Min 8 characters required" : null,
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       obscureText: _isObscuredOne,
//                       style: AppStyles.bodyStyle,
//                       decoration: AppStyles.textFieldDecoration.copyWith(
//                         labelText: "Confirm Password",
//                         prefixIcon: Icon(Icons.lock_reset, color: AppColors.primaryCoral),
//                         suffixIcon: IconButton(
//                           icon: Icon(_isObscuredOne ? Icons.visibility_off : Icons.visibility),
//                           onPressed: () => setState(() => _isObscuredOne = !_isObscuredOne),
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v != _passwordController.text) return "Passwords do not match";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 30),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 55,
//                       child: ElevatedButton(
//                         onPressed: isLoading ? null : _onSubmit,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryCoral,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                           elevation: 5,
//                         ),
//                         child: isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : const Text("SignUp", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                     const SizedBox(height: 25),
//                     Center(
//                       child: RichText(
//                         text: TextSpan(
//                           style: const TextStyle(color: Colors.grey, fontSize: 16),
//                           children: [
//                             const TextSpan(text: "Already have an Account? "),
//                             TextSpan(
//                               text: "SignIn",
//                               style: TextStyle(color: AppColors.primaryCoral, fontWeight: FontWeight.bold),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () => Navigator.pushNamed(context, AppRoute.signIn),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:login/core/constants/app_colors.dart';
import 'package:login/core/constants/app_routes.dart';
import 'package:login/core/constants/app_styles.dart';
import 'package:login/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // States
  bool _isObscured = true;
  bool _isObscuredConfirm = true;

  @override
  void dispose() {
    // মেমরি লিক রোধ করতে কন্ট্রোলারগুলো ডিসপোজ করা হয়েছে
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _onSubmit() async {
    if (_key.currentState!.validate()) {
      // আপনার প্রোভাইডার ক্লাসের নাম auth_Provider হলে এটি ঠিক আছে
      final authProvider = context.read<auth_Provider>();

      try {
        await authProvider.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (mounted) {
          _showMessage("Account Created Successfully!");
          // সফল হলে সাইন-ইন পেজে পাঠানো হচ্ছে এবং স্ট্যাক ক্লিয়ার করা হচ্ছে
          Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (route) => false);
        }
      } catch (e) {
        if (mounted) {
          _showMessage(e.toString(), isError: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // লোডিং স্টেট ওয়াচ করা (UI আপডেট করার জন্য)
    final isLoading = context.watch<auth_Provider>().isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header with Wave Design
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                color: AppColors.primaryCoral,
                child: const Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Sign Up",
                        style: AppStyles.headingStyle.copyWith(color: Colors.black, fontSize: 26)
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppStyles.textFieldDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryCoral),
                        hintText: 'example@gmail.com',
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Email is required";
                        if (!v.contains('@')) return "Enter a valid email";
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscured,
                      decoration: AppStyles.textFieldDecoration.copyWith(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryCoral),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _isObscured = !_isObscured),
                        ),
                      ),
                      validator: (v) => (v == null || v.length < 8) ? "Password must be at least 8 chars" : null,
                    ),
                    const SizedBox(height: 15),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _isObscuredConfirm,
                      decoration: AppStyles.textFieldDecoration.copyWith(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock_reset, color: AppColors.primaryCoral),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscuredConfirm ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _isObscuredConfirm = !_isObscuredConfirm),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Please confirm your password";
                        if (v != _passwordController.text) return "Passwords do not match";
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    // SignUp Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryCoral,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Back to Login Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.grey, fontSize: 15),
                          children: [
                            const TextSpan(text: "Already have an Account? "),
                            TextSpan(
                              text: "SignIn",
                              style: const TextStyle(
                                color: AppColors.primaryCoral,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(context, AppRoute.signIn),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}