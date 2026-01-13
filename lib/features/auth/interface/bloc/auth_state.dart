part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

enum AuthIntent {
  none,
  skip,
  signin,
  signup,
  resetPassword,
  socialSignIn,
  readTermsAndConditions,
}

enum AuthOutcome {
  none,
  inProcess,
  success,
  failure,
}

String? authMessage;

Map<String, String> authProgressMessage = {
  'signin': 'Signing In, Please wait ...',
  'signup': 'Signing Up, Please wait ...',
  'resetPassword': 'Resetting Password, please wait ...',
};

Map<String, String> signUpMessages = {
  'success': 'Signup completed Successfully!',
};
Map<String, String> resetPassword = {
  'success': 'Password reset link sent to email, please check your mailbox',
};

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthIntent intent;
  final AuthOutcome outcome;
  final String? message;
  final dynamic data;

  AuthState({
    this.status = AuthStatus.unknown,
    this.intent = AuthIntent.none,
    this.outcome = AuthOutcome.none,
    this.message = '',
    this.data,
  });

  @override
  List<Object?> get props => [status, intent, outcome, message];

  AuthState copyWith({
    AuthStatus? status,
    AuthIntent? intent,
    AuthOutcome? outcome,
    String? message,
    dynamic data,
  }) {
    return AuthState(
      status: status ?? this.status,
      intent: intent ?? this.intent,
      outcome: outcome ?? this.outcome,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class InputFocusState extends AuthState {
  final bool focus;
  InputFocusState({
    this.focus = false,
  });

  @override
  List<Object?> get props => [focus];
}
