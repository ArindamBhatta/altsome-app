import 'package:altsome_app/config/routes.dart';
import 'package:altsome_app/config/theme.dart';
import 'package:altsome_app/core/services/firebase_service.dart';

import 'package:altsome_app/features/auth/bloc/auth_bloc.dart';
import 'package:altsome_app/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await FirebaseService.init();
    runApp(const AltsomeApp());
  } catch (error) {
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Failed to initialize Firebase. Please try again.'),
        ),
      ),
    );
  }
}

class AltsomeApp extends StatelessWidget {
  final AuthRepository? authRepository;

  const AltsomeApp({super.key, this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(authRepository: authRepository!),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Initialize Router with access to AuthBloc
    _router = createRouter(context.read<AuthBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Altsome',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
