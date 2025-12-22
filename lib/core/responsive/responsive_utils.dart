import 'package:altsome_app/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

/// Centralized responsive design utilities following best practices
class ResponsiveUtils {
  /// Responsive text styles based on size class
  static TextStyle getResponsiveTextStyle(
    BuildContext context, {
    required TextStyle baseStyle,
    double? compactScale,
    double? cozyScale,
    double? mediumScale,
    double? largeScale,
    double? xlargeScale,
  }) {
    final sizeClass = context.sizeClass;
    final scale = context.rScale;

    double fontScale = 1.0;
    switch (sizeClass) {
      case AppSizeClass.compact:
        fontScale = compactScale ?? 0.9;
        break;
      case AppSizeClass.cozy:
        fontScale = cozyScale ?? 1.0;
        break;
      case AppSizeClass.medium:
        fontScale = mediumScale ?? 1.1;
        break;
      case AppSizeClass.large:
        fontScale = largeScale ?? 1.2;
        break;
      case AppSizeClass.xlarge:
        fontScale = xlargeScale ?? 1.3;
        break;
    }

    return baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 14) * fontScale * scale,
    );
  }

  /// Responsive spacing values
  static double getResponsiveSpacing(
    BuildContext context, {
    required double baseSpacing,
    double? compactScale,
    double? cozyScale,
    double? mediumScale,
    double? largeScale,
    double? xlargeScale,
  }) {
    return context.r(
      compact: baseSpacing * (compactScale ?? 0.85),
      cozy: baseSpacing * (cozyScale ?? 1.0),
      medium: baseSpacing * (mediumScale ?? 1.15),
      large: baseSpacing * (largeScale ?? 1.3),
      xlarge: baseSpacing * (xlargeScale ?? 1.5),
    );
  }

  /// Responsive icon size
  static double getResponsiveIconSize(
    BuildContext context, {
    required double baseSize,
  }) {
    return context.r(
      compact: baseSize * 0.9,
      cozy: baseSize,
      medium: baseSize * 1.1,
      large: baseSize * 1.2,
      xlarge: baseSize * 1.3,
    );
  }

  /// Responsive padding
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    double? horizontal,
    double? vertical,
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    final scale = context.rScale;

    if (all != null) {
      return EdgeInsets.all(all * scale);
    }

    return EdgeInsets.only(
      left: (left ?? horizontal ?? 0) * scale,
      top: (top ?? vertical ?? 0) * scale,
      right: (right ?? horizontal ?? 0) * scale,
      bottom: (bottom ?? vertical ?? 0) * scale,
    );
  }

  /// Responsive border radius
  static BorderRadius getResponsiveBorderRadius(
    BuildContext context, {
    required double baseRadius,
  }) {
    final scale = context.rScale;
    return BorderRadius.circular(baseRadius * scale);
  }

  /// Responsive container dimensions
  static double getResponsiveHeight(
    BuildContext context, {
    required double baseHeight,
  }) {
    return context.r(
      compact: baseHeight * 0.85,
      cozy: baseHeight,
      medium: baseHeight * 1.1,
      large: baseHeight * 1.2,
      xlarge: baseHeight * 1.3,
    );
  }

  static double getResponsiveWidth(
    BuildContext context, {
    required double baseWidth,
  }) {
    return context.r(
      compact: baseWidth * 0.85,
      cozy: baseWidth,
      medium: baseWidth * 1.1,
      large: baseWidth * 1.2,
      xlarge: baseWidth * 1.3,
    );
  }
}

/// Responsive styles value object for project stages
class ProjectStagesResponsiveStyles {
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle bodyStyle;
  final TextStyle captionStyle;
  final TextStyle statusStyle;
  final TextStyle progressTextStyle;
  final double iconSize;
  final double statusIconSize;
  final double spacing;
  final double cardPadding;
  final double borderRadius;
  final double progressBarHeight;

  ProjectStagesResponsiveStyles._({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.bodyStyle,
    required this.captionStyle,
    required this.statusStyle,
    required this.progressTextStyle,
    required this.iconSize,
    required this.statusIconSize,
    required this.spacing,
    required this.cardPadding,
    required this.borderRadius,
    required this.progressBarHeight,
  });

  factory ProjectStagesResponsiveStyles.from(
    BuildContext context,
    TextTheme textTheme,
  ) {
    final sizeClass = context.sizeClass;
    final scale = context.rScale;

    return ProjectStagesResponsiveStyles._(
      titleStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: textTheme.headlineSmall ?? const TextStyle(fontSize: 24),
      ),
      subtitleStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: textTheme.titleMedium ?? const TextStyle(fontSize: 16),
      ),
      bodyStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: textTheme.bodyLarge ?? const TextStyle(fontSize: 16),
      ),
      captionStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: textTheme.bodySmall ?? const TextStyle(fontSize: 12),
      ),
      statusStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      progressTextStyle: ResponsiveUtils.getResponsiveTextStyle(
        context,
        baseStyle: const TextStyle(fontSize: 14),
      ),
      iconSize: ResponsiveUtils.getResponsiveIconSize(context, baseSize: 24),
      statusIconSize:
          ResponsiveUtils.getResponsiveIconSize(context, baseSize: 20),
      spacing: ResponsiveUtils.getResponsiveSpacing(context, baseSpacing: 16),
      cardPadding:
          ResponsiveUtils.getResponsiveSpacing(context, baseSpacing: 16),
      borderRadius: context.r(compact: 12, cozy: 16, medium: 16, large: 20),
      progressBarHeight:
          context.r(compact: 40, cozy: 48, medium: 52, large: 56),
    );
  }
}
