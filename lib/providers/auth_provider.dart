import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';

class auth_Provider extends ChangeNotifier {
  // Instance of the service we created
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // State variables
  bool _isLoading = false;
  String? _errorMessage;

  // Getters to access private variables from UI
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Login Method
  Future<void> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signInWithEmail(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow; // Sends the error to the UI for SnackBar/Dialog
    } finally {
      _setLoading(false);
    }
  }

  /// SignUp Method
  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signUpWithEmail(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Logout Method
  Future<void> logout() async {
    try {
      await _authService.signOut();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    }
  }

  // auth_provider.dart এর ভেতরে
  // Future<void> resetPassword(String email) async {
  //   try {
  //     // Firebase এই একটি লাইনের মাধ্যমেই ইমেইল পাঠিয়ে দেয়
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //   } on FirebaseAuthException catch (e) {
  //     // যদি ইমেইলটি রেজিস্টার্ড না থাকে বা অন্য কোনো এরর হয়
  //     if (e.code == 'user-not-found') {
  //       throw "No user found with this email.";
  //     } else if (e.code == 'invalid-email') {
  //       throw "The email address is badly formatted.";
  //     }
  //     throw e.message ?? "An error occurred. Try again.";
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }




  Future<void> resetPassword(String email) async {
    try {
      // Sending the reset email link directly
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Firebase provides specific error codes if Email Enumeration is disabled
      if (e.code == 'user-not-found') {
        throw "This email is not registered. Please create an account first.";
      } else if (e.code == 'invalid-email') {
        throw "The email format is invalid. Please check and try again.";
      } else if (e.code == 'network-request-failed') {
        throw "Network error. Please check your internet connection.";
      }

      // Generic Firebase error message
      throw e.message ?? "An unexpected error occurred.";
    } catch (e) {
      // Catching any other non-Firebase errors
      throw "An error occurred during processing: $e";
    }
  }





  // Private helper to manage loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Private helper to clear old errors
  void _clearError() {
    _errorMessage = null;
  }
}