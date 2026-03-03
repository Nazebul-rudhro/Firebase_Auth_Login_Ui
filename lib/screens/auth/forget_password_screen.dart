// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:login/core/constants/app_colors.dart';
// import 'package:login/core/constants/app_routes.dart';
// import 'package:login/core/constants/app_styles.dart';
//
// class ForgetPasswordScreen extends StatelessWidget{
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           child: Center(
//             child:  Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock_reset, size: 28, fontWeight: FontWeight.bold,),
//                 Text("Forgot Password?", style: AppStyles.headingStyle,),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Form(child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: AppStyles.textFieldDecoration.copyWith(
//                         labelText: "Email",
//                         hint: Row(
//                           children: [
//                             Icon(Icons.email_outlined, color: Colors.grey,),
//                             SizedBox(width: 10,),
//                             Text("Enter Your Email"),
//                           ],
//                         )
//                       ),
//                     )
//                   ],
//                 )),
//
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(width: double.infinity,
//                 child: ElevatedButton(onPressed: (){}, child: Text("Reset Password"), style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryCoral,
//                   foregroundColor: Colors.white
//                 ),),),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 TextButton(onPressed: (){ Navigator.pushNamed(context, AppRoute.signIn);}, child: Text("Back to Login")),
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }



import 'package:flutter/material.dart';
import 'package:login/core/constants/app_colors.dart';
import 'package:login/core/constants/app_routes.dart';
import 'package:login/core/constants/app_styles.dart';
import 'package:login/providers/auth_provider.dart'; // Make sure this is imported
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // Calling the reset method from your AuthProvider
        await context.read<auth_Provider>().resetPassword(_emailController.text.trim());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Reset link sent! Check your email."), backgroundColor: Colors.green),
          );
          Navigator.pushNamed(context, AppRoute.signIn);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView( // Added scroll to avoid overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_reset, size: 80, color: AppColors.primaryCoral),
                  const SizedBox(height: 10),
                  Text("Forgot Password?", style: AppStyles.headingStyle),
                  const SizedBox(height: 10),
                  const Text("Enter your email to receive a password reset link.",
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),

                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppStyles.textFieldDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryCoral),
                        hintText: "Enter Your Email",
                      ),
                      validator: (value) => (value == null || !value.contains("@")) ? "Enter a valid email" : null,
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleReset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryCoral,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Send Reset Link", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context), // Better to use pop to go back
                    child: const Text("Back to Login", style: TextStyle(color: AppColors.primaryCoral)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}