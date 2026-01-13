import 'dart:async';

import 'package:altsome_app/features/auth/data/service/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription? _stream;

  AuthBloc() : super(AuthState()) {
    on<InputFocus>(_onInputFocus);
    on<AuthGoogleSignIn>(_onAuthGoogleSignIn);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthResetPassword>(_onAuthResetPassword);
  }

  void _onInputFocus(InputFocus event, emit) {
    emit(InputFocusState(focus: event.focus));
  }

  Future<void> _onAuthGoogleSignIn(AuthGoogleSignIn event, emit) async {
    emit(state.copyWith(
        intent: AuthIntent.socialSignIn, outcome: AuthOutcome.inProcess));
    final result = await AuthService.signInWithGoogle();
    if (result['status'] == true) {
      emit(state.copyWith(
          status: AuthStatus.authenticated, outcome: AuthOutcome.success));
    } else {
      emit(state.copyWith(
          outcome: AuthOutcome.failure, message: result['message']));
    }
  }

  void _onAuthSignOut(AuthSignOut event, emit) {
    emit(AuthState(status: AuthStatus.unauthenticated));
  }

  void _onAuthResetPassword(AuthResetPassword event, emit) {
    emit(AuthState(status: AuthStatus.authenticated));
  }
}
