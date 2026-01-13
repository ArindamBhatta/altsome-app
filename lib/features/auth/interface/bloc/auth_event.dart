part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthGoogleSignIn extends AuthEvent {}

class AuthTwitterSignIn extends AuthEvent {}

class AuthSignOut extends AuthEvent {}

class InputFocus extends AuthEvent {
  final bool focus;
  InputFocus(this.focus);
}

class AuthResetPassword extends AuthEvent {
  final String userEmail;
  AuthResetPassword({
    required this.userEmail,
  });
}
