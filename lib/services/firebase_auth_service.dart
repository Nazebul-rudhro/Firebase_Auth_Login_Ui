import 'package:firebase_auth/firebase_auth.dart';

/// A service class to handle all Firebase Authentication logic.
/// This keeps the UI and Business Logic separate.
class FirebaseAuthService {
  // 1. Create a private instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 2. Auth State Stream
  // This stream notifies the app whenever the user logs in or out.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 3. Sign In with Email and Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Catching specific Firebase errors and throwing custom messages
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // 4. Sign Up with Email and Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // 5. Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  // Helper method to handle Firebase-specific error codes
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Authentication failed. Error: ${e.code}';
    }
  }
}