import 'dart:async';
import 'package:altsome_app/core/utils/app_logger.dart';
import 'package:altsome_app/core/widgets/error.dart';
import 'package:altsome_app/page/login/provider/auth_provider.dart';
import 'package:altsome_app/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoute {
  static const splash = '/splash';
  static const login = '/login';
}

// Provider for the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.splash,
    debugLogDiagnostics: true,
    routes: [
      // Define routes using AppRoute constants
      GoRoute(
        path: AppRoute.splash,
        name: AppRoute.splash,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final String currentPath = state.matchedLocation;
      AppLogger.logger.d("Redirect check: Current location = $currentPath");
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authStateChangesProvider.stream),
    ),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env.dev");
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception(
        '.env file not found or SUPABASE_URL/SUPABASE_ANON_KEY missing.',
      );
    }

    AppLogger.logger.i('Initializing Supabase...');
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    AppLogger.logger.i('Supabase initialized successfully.');

    runApp(const ProviderScope(child: AltsomeApp()));
  } catch (e, stackTrace) {
    AppLogger.logger.e(
      'Error initializing app',
      error: e,
      stackTrace: stackTrace,
    );
    // Consider showing a more user-friendly error UI using the router if possible
    runApp(ErrorApp(error: e.toString()));
  }
}

class AltsomeApp extends HookConsumerWidget {
  const AltsomeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider); // Watch the router provider

    return MaterialApp.router(
      title: 'Altsome',
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
