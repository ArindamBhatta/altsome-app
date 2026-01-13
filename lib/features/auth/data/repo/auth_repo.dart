import 'dart:async';
import 'package:altsome_app/features/auth/data/model/auth_model.dart';
import 'package:altsome_app/features/auth/data/service/auth_service.dart';

class AuthRepo {
  static AuthRepo? _instance;

  final StreamController<AuthModel?> _controller =
      StreamController<AuthModel?>.broadcast();

  Stream<AuthModel?> get stream => _controller.stream;

  AuthRepo._internal() {
    AuthService.init(); // Initialize the auth state listener
    AuthService.stream.listen((userData) {
      if (userData != null && userData.containsKey('id')) {
        _controller.add(AuthModel.fromJson(userData));
      } else {
        _controller.add(null);
      }
    });
  }

  factory AuthRepo() {
    _instance ??= AuthRepo._internal();
    return _instance!;
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    return await AuthService.signInWithGoogle();
  }

  Future<Map<String, dynamic>> signInWithTwitter() async {
    return await AuthService.signInWithTwitter();
  }

  Future<void> signOut() async {
    await AuthService.signOut();
  }
}
