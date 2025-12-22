import 'package:flutter/material.dart';

/// A utility class to manage splash screen configuration
class SplashHelper {
  /// Default splash screen duration in seconds
  static const int defaultDuration = 2;

  /// App logo size
  static const double logoSize = 120.0;

  /// App name font size
  static const double appNameFontSize = 28.0;

  /// Subtitle font size
  static const double subtitleFontSize = 20.0;

  /// Logo border radius
  static const double logoBorderRadius = 20.0;

  /// Loader size
  static const double loaderSize = 40.0;

  /// Letter spacing for app name
  static const double appNameLetterSpacing = 2.0;

  /// Letter spacing for subtitle
  static const double subtitleLetterSpacing = 1.0;

  /// Generate box shadow for logo
  static List<BoxShadow> getLogoShadow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.3),
        blurRadius: 15,
        spreadRadius: 5,
      ),
    ];
  }

  /// Generate logo decoration
  static BoxDecoration getLogoDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(logoBorderRadius),
      boxShadow: getLogoShadow(color),
    );
  }

  /// Get app name text style
  static TextStyle getAppNameStyle(Color color) {
    return TextStyle(
      fontSize: appNameFontSize,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: appNameLetterSpacing,
    );
  }

  /// Get subtitle text style
  static TextStyle getSubtitleStyle(Color color) {
    return TextStyle(
      fontSize: subtitleFontSize,
      color: color,
      letterSpacing: subtitleLetterSpacing,
    );
  }
}
