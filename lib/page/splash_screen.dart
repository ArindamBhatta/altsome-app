import 'package:altsome_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainImage;
  late AnimationController _subImage;
  late AnimationController _backgroundImage;

  @override
  void initState() {
    super.initState();
    _mainImage = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _subImage = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _backgroundImage = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // 1. Start background animation first
    _backgroundImage.forward();

    _backgroundImage.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 2. Then showing logo and text
        if (mounted) {
          _mainImage.forward();
          _subImage.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _mainImage.dispose();
    _subImage.dispose();
    _backgroundImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive logo size
          final logoSize = size.width * 0.3;
          const maxLogoSize = 180.0;
          const minLogoSize = 90.0;
          final actualLogoSize = logoSize.clamp(minLogoSize, maxLogoSize);

          return Stack(
            children: [
              // Background image that fades in last
              FadeTransition(
                opacity: _backgroundImage,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/splash_background.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: _subImage,
                      child: Text(
                        'Altsome',
                        style: GoogleFonts.outfit(
                          textStyle: theme.textTheme.displayMedium,
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    FadeTransition(
                      opacity: _mainImage,
                      child: Image.asset(
                        'assets/images/fox_mask_logo.png',
                        width: maxLogoSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              // Responsive bottom content
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.height * 0.02,
                  ),
                  child: FadeTransition(
                    opacity: _backgroundImage,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome to Altsome",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.05, // responsive font
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.outfit(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
