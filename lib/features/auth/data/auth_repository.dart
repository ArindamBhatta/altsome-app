import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final Logger _logger = Logger();

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      _logger.e("Sign Up Error", error: e);
      throw LogInWithEmailAndPasswordFailure.fromCode(e);
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      _logger.e("Log In Error", error: e);
      throw LogInWithEmailAndPasswordFailure.fromCode(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception("Log out failed");
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return const LogInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.',
          );
        case 'user-disabled':
          return const LogInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help.',
          );
        case 'user-not-found':
          return const LogInWithEmailAndPasswordFailure(
            'Email is not found, please create an account.',
          );
        case 'wrong-password':
          return const LogInWithEmailAndPasswordFailure(
            'Incorrect password, please try again.',
          );
        default:
          return const LogInWithEmailAndPasswordFailure();
      }
    }
    return const LogInWithEmailAndPasswordFailure();
  }
}
