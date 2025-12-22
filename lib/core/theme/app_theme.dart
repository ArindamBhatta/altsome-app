import 'package:altsome_app/core/constants/app_colors.dart';
import 'package:altsome_app/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

/// Central theme configuration for the application
class AppTheme {
  // Private constants
  static const double _defaultBorderRadius = 8.0;
  static const double _largeBorderRadius = 16.0;
  static const double _buttonHeight = 58.0;

  /// Responsive breakpoints
  static const double breakpointNarrow = 300.0;
  static const double breakpointMedium = 600.0;
  static const double breakpointWide = 900.0;

  /// Info card dimensions
  static const double cardMinWidth =
      160.0; // Minimum target width for each card
  static const double cardHeight = 80.0;
  static const double vehicleImageSize = 100.0;
  static const double progressBarHeight = 6.0;

  /// Default spacing values for consistent padding/margin
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 40.0;

  /// Border radius values for consistent styling
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 16.0;

  /// Responsive typography sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;

  /// Responsive icon sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 20.0;
  static const double iconSizeL = 24.0;
  static const double iconSizeXL = 32.0;

  /// UI element dimensions
  static const double progressIndicatorSize = 20.0;
  static const double progressIndicatorSizeCompact = 16.0;
  static const double photoGridAspectRatio = 1.5;
  static const double strokeWidthThin = 2.0;
  static const double strokeWidthMedium = 3.0;

  /// Shadow presets for elevation
  static final List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Card shape for consistent styling
  static RoundedRectangleBorder get cardShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusM),
      );

  /// Standard padding presets
  static EdgeInsets get paddingAll => const EdgeInsets.all(spacingM);
  static EdgeInsets get paddingHorizontal =>
      const EdgeInsets.symmetric(horizontal: spacingM);
  static EdgeInsets get paddingVertical =>
      const EdgeInsets.symmetric(vertical: spacingM);
  static EdgeInsets get paddingLarge => const EdgeInsets.all(spacingL);
  static EdgeInsets get paddingForm => const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      );

  /// Content padding for sections
  static EdgeInsets get contentPadding => const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingM,
      );

  /// Vehicle details theming
  static BoxDecoration infoCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadiusM),
      boxShadow: lightShadow,
    );
  }

  static TextStyle sectionHeaderStyle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static Color sectionIconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF00E5FF)
          : const Color(0xFF00E5FF);

  static Color progressBarColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF00E5FF)
          : const Color(0xFF00E5FF);

  /// Progress section
  static TextStyle progressItemStyle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle progressLabelStyle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
    );
  }

  /// Card styling for info sections
  static TextStyle infoCardLabelStyle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
    );
  }

  static TextStyle infoCardValueStyle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  /// Helper method to calculate optimal columns based on width
  static int getOptimalColumns(double availableWidth) {
    return max(1, (availableWidth / cardMinWidth).floor());
  }

  /// Responsive typography helpers
  static double responsiveFontSize(
    BuildContext context, {
    double? compact,
    double? cozy,
    double? medium,
    double? large,
    double? xlarge,
  }) {
    final sizeClass = AppResponsive.sizeClassOf(context);
    switch (sizeClass) {
      case AppSizeClass.compact:
        return compact ?? fontSizeS;
      case AppSizeClass.cozy:
        return cozy ?? compact ?? fontSizeM;
      case AppSizeClass.medium:
        return medium ?? cozy ?? compact ?? fontSizeL;
      case AppSizeClass.large:
        return large ?? medium ?? cozy ?? compact ?? fontSizeXL;
      case AppSizeClass.xlarge:
        return xlarge ?? large ?? medium ?? cozy ?? compact ?? fontSizeXXL;
    }
  }

  /// Responsive icon size helpers
  static double responsiveIconSize(
    BuildContext context, {
    double? compact,
    double? cozy,
    double? medium,
  }) {
    final sizeClass = AppResponsive.sizeClassOf(context);
    switch (sizeClass) {
      case AppSizeClass.compact:
        return compact ?? iconSizeS;
      case AppSizeClass.cozy:
        return cozy ?? compact ?? iconSizeM;
      default:
        return medium ?? cozy ?? compact ?? iconSizeL;
    }
  }

  /// Responsive UI element sizing
  static double responsiveProgressSize(BuildContext context) {
    final sizeClass = AppResponsive.sizeClassOf(context);
    return sizeClass == AppSizeClass.compact
        ? progressIndicatorSizeCompact
        : progressIndicatorSize;
  }

  /// Responsive spacing helpers
  static double responsiveSpacing(
    BuildContext context, {
    double? compact,
    double? cozy,
    double? medium,
  }) {
    final sizeClass = AppResponsive.sizeClassOf(context);
    switch (sizeClass) {
      case AppSizeClass.compact:
        return compact ?? spacingXS;
      case AppSizeClass.cozy:
        return cozy ?? compact ?? spacingS;
      default:
        return medium ?? cozy ?? compact ?? spacingM;
    }
  }

  /// Grid delegate for consistent info card grids
  static SliverGridDelegateWithFixedCrossAxisCount infoGridDelegate(
      int columns) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: columns,
      childAspectRatio: 3.0,
      crossAxisSpacing: spacingM,
      mainAxisSpacing: spacingM,
      mainAxisExtent: cardHeight,
    );
  }

  /// Get light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _getLightColorScheme(),
      textTheme: _getTextTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      // cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(),
      dividerTheme: _dividerTheme(),
      iconTheme: _iconTheme(),
      chipTheme: _chipTheme(),
      extensions: [
        CustomComponentsTheme(
          statusBadgeStyle: StatusBadgeStyle(
            borderRadius: _defaultBorderRadius / 2,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottomNavigationStyle: BottomNavigationStyle(
            backgroundColor: _getLightColorScheme().surface,
            centerButtonColor: AppColors.primary,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Get dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _getDarkColorScheme(),
      textTheme: _getTextTheme(isDark: true),
      elevatedButtonTheme: _elevatedButtonTheme(isDark: true),
      outlinedButtonTheme: _outlinedButtonTheme(isDark: true),
      textButtonTheme: _textButtonTheme(isDark: true),
      inputDecorationTheme: _inputDecorationTheme(isDark: true),
      // cardTheme: _cardTheme(isDark: true),
      appBarTheme: _appBarTheme(isDark: true),
      dividerTheme: _dividerTheme(isDark: true),
      iconTheme: _iconTheme(isDark: true),
      chipTheme: _chipTheme(isDark: true),
      extensions: [
        CustomComponentsTheme(
          statusBadgeStyle: StatusBadgeStyle(
            borderRadius: _defaultBorderRadius / 2,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottomNavigationStyle: BottomNavigationStyle(
            backgroundColor: _getDarkColorScheme().surface,
            centerButtonColor: AppColors.primary,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textOnDark.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  // Private helper methods for theme components

  static ColorScheme _getLightColorScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryLight,
      surface: AppColors.cardBackground,
      error: AppColors.errorColor,
      onPrimary: AppColors.textOnPrimary,
      onSecondary: Colors.black,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    );
  }

  static ColorScheme _getDarkColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary:
          AppColors.primary, // Keep red as primary for buttons and main actions
      primaryContainer: AppColors.primaryDark,
      secondary:
          AppColors.secondary, // Keep blue as secondary for progress/status
      secondaryContainer: AppColors.secondaryDark,
      surface: AppColors.darkBackground,
      surfaceVariant:
          const Color(0xFF1E1E1E), // Slightly lighter surface for cards
      error: AppColors.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textOnDark,
      onSurfaceVariant: AppColors.textOnDark.withOpacity(0.8),
      onError: Colors.white,
      background: AppColors.darkBackground,
      onBackground: AppColors.textOnDark,
    );
  }

  static TextTheme _getTextTheme({bool isDark = false}) {
    final Color mainTextColor = isDark ? Colors.white : AppColors.textPrimary;
    final Color secondaryTextColor =
        isDark ? AppColors.textOnDark : AppColors.textSecondary;

    // Use GoogleFonts.poppinsTextTheme for better performance and consistency
    final baseTextTheme = isDark
        ? GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
        : GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme);

    // Customize specific styles with proper colors and enhanced titleLarge for headers
    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w600,
      ),
      // Enhanced titleLarge specifically for page headers
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: mainTextColor,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: mainTextColor,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: mainTextColor,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: secondaryTextColor,
      ),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        color: mainTextColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        color: secondaryTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme({bool isDark = false}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_defaultBorderRadius),
        ),
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.3),
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacingL, vertical: spacingM),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme({bool isDark = false}) {
    final Color borderColor = isDark ? Colors.white70 : AppColors.primary;

    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : AppColors.primary,
        minimumSize: const Size(double.infinity, _buttonHeight),
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_defaultBorderRadius),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacingL, vertical: spacingM),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme({bool isDark = false}) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: isDark ? Colors.white : AppColors.primary,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: spacingM, vertical: spacingS),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({bool isDark = false}) {
    final Color borderColor = isDark ? Colors.white54 : AppColors.borderColor;
    final Color fillColor = isDark ? Colors.black12 : Colors.white;

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingL,
        vertical: spacingL,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      hintStyle: GoogleFonts.poppins(
        color: isDark ? Colors.white54 : AppColors.textLight,
        fontSize: 16,
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDark ? Colors.white70 : AppColors.textSecondary,
        fontSize: 16,
      ),
    );
  }

  static CardTheme _cardTheme({bool isDark = false}) {
    return CardTheme(
      color: isDark
          ? AppColors.darkBackground.withOpacity(0.8)
          : AppColors.cardBackground,
      elevation: 4,
      shadowColor: AppColors.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
      ),
      margin:
          const EdgeInsets.symmetric(vertical: spacingS, horizontal: spacingS),
    );
  }

  static AppBarTheme _appBarTheme({bool isDark = false}) {
    return AppBarTheme(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.primary,
      foregroundColor: Colors
          .white, // Ensures all AppBar content is white on primary background
      elevation: 10,
      scrolledUnderElevation: 16,
      shadowColor: Colors.black.withOpacity(0.45),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppTheme.borderRadiusL),
        ),
      ),
    );
  }

  // Secondary AppBar theme for screens with surface background (like profile)
  static AppBarTheme surfaceAppBarTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface, // Ensures proper contrast
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: colorScheme.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
    );
  }

  static DividerThemeData _dividerTheme({bool isDark = false}) {
    return DividerThemeData(
      color: isDark ? Colors.white24 : AppColors.dividerColor,
      thickness: 1,
      space: spacingM,
    );
  }

  static IconThemeData _iconTheme({bool isDark = false}) {
    return IconThemeData(
      color: isDark ? Colors.white : AppColors.textPrimary,
      size: 24,
    );
  }

  static ChipThemeData _chipTheme({bool isDark = false}) {
    return ChipThemeData(
      backgroundColor: isDark ? Colors.white12 : AppColors.background,
      disabledColor: AppColors.disabledBackground,
      selectedColor: AppColors.primary.withOpacity(0.2),
      padding:
          const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingXS),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDark ? Colors.white : AppColors.textPrimary,
        fontSize: 14,
      ),
    );
  }

  // Shadow helpers
  static List<BoxShadow> get defaultShadow => [
        const BoxShadow(
          color: AppColors.shadowColor,
          blurRadius: 10,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ];

  static List<BoxShadow> get heavyShadow => [
        BoxShadow(
          color: AppColors.shadowColor.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
          spreadRadius: 2,
        )
      ];
}

/// Custom theme extension for components not covered by Material
class CustomComponentsTheme extends ThemeExtension<CustomComponentsTheme> {
  final StatusBadgeStyle statusBadgeStyle;
  final BottomNavigationStyle bottomNavigationStyle;

  CustomComponentsTheme({
    required this.statusBadgeStyle,
    required this.bottomNavigationStyle,
  });

  @override
  ThemeExtension<CustomComponentsTheme> copyWith({
    StatusBadgeStyle? statusBadgeStyle,
    BottomNavigationStyle? bottomNavigationStyle,
  }) {
    return CustomComponentsTheme(
      statusBadgeStyle: statusBadgeStyle ?? this.statusBadgeStyle,
      bottomNavigationStyle:
          bottomNavigationStyle ?? this.bottomNavigationStyle,
    );
  }

  @override
  ThemeExtension<CustomComponentsTheme> lerp(
      ThemeExtension<CustomComponentsTheme>? other, double t) {
    if (other is! CustomComponentsTheme) {
      return this;
    }

    return CustomComponentsTheme(
      statusBadgeStyle:
          StatusBadgeStyle.lerp(statusBadgeStyle, other.statusBadgeStyle, t),
      bottomNavigationStyle: BottomNavigationStyle.lerp(
          bottomNavigationStyle, other.bottomNavigationStyle, t),
    );
  }
}

/// Style for status badges
class StatusBadgeStyle {
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const StatusBadgeStyle({
    required this.borderRadius,
    required this.padding,
    required this.textStyle,
  });

  static StatusBadgeStyle lerp(
      StatusBadgeStyle a, StatusBadgeStyle b, double t) {
    return StatusBadgeStyle(
      borderRadius: lerpDouble(a.borderRadius, b.borderRadius, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t)!,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t)!,
    );
  }
}

/// Style for bottom navigation
class BottomNavigationStyle {
  final Color backgroundColor;
  final Color centerButtonColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double height;
  final double notchMargin;
  final double centerButtonSize;

  const BottomNavigationStyle({
    required this.backgroundColor,
    required this.centerButtonColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    this.height = 80.0,
    this.notchMargin = 8.0,
    this.centerButtonSize = 56.0,
  });

  static BottomNavigationStyle lerp(
      BottomNavigationStyle a, BottomNavigationStyle b, double t) {
    return BottomNavigationStyle(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      centerButtonColor:
          Color.lerp(a.centerButtonColor, b.centerButtonColor, t)!,
      selectedItemColor:
          Color.lerp(a.selectedItemColor, b.selectedItemColor, t)!,
      unselectedItemColor:
          Color.lerp(a.unselectedItemColor, b.unselectedItemColor, t)!,
      height: lerpDouble(a.height, b.height, t),
      notchMargin: lerpDouble(a.notchMargin, b.notchMargin, t),
      centerButtonSize: lerpDouble(a.centerButtonSize, b.centerButtonSize, t),
    );
  }
}

/// Helper method for lerping doubles
double lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
