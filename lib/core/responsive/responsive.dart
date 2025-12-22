import 'package:flutter/widgets.dart';

enum AppSizeClass { compact, cozy, medium, large, xlarge }

class AppResponsive {
  static double _shortSide(BuildContext c) => MediaQuery.sizeOf(c).shortestSide;

  static AppSizeClass sizeClassOf(BuildContext c) {
    final s = _shortSide(c);
    if (s < 360) return AppSizeClass.compact; // tiny phones
    if (s < 400) return AppSizeClass.cozy; // typical phones
    if (s < 600) return AppSizeClass.medium; // big phones / small tabs
    if (s < 840) return AppSizeClass.large; // tablets / folded Fold
    return AppSizeClass.xlarge; // unfolded Fold / big tablets
  }

  // Conservative base UI scale (pre-accessibility)
  static double baseScaleOf(BuildContext c) {
    switch (sizeClassOf(c)) {
      case AppSizeClass.compact:
        return 0.92;
      case AppSizeClass.cozy:
        return 1.00;
      case AppSizeClass.medium:
        return 1.08;
      case AppSizeClass.large:
        return 1.16;
      case AppSizeClass.xlarge:
        return 1.22;
    }
  }

  /// Clamped accessibility text scale: respect OS but keep layouts sane.
  static double textScale(
    BuildContext c, {
    double min = 0.85,
    double max = 1.30,
  }) {
    // Flutter 3.16+: MediaQuery.textScalerOf(c).scale(1.0)
    final osScale = MediaQuery.textScalerOf(c).scale(1.0);
    return osScale.clamp(min, max);
  }

  /// UI scale for icons/typography base sizing (exclude OS text scale)
  static double scaleOf(BuildContext c) => baseScaleOf(c);

  static T value<T>(
    BuildContext c, {
    required T compact,
    T? cozy,
    T? medium,
    T? large,
    T? xlarge,
  }) {
    switch (sizeClassOf(c)) {
      case AppSizeClass.compact:
        return compact;
      case AppSizeClass.cozy:
        return cozy ?? compact;
      case AppSizeClass.medium:
        return medium ?? cozy ?? compact;
      case AppSizeClass.large:
        return large ?? medium ?? cozy ?? compact;
      case AppSizeClass.xlarge:
        return xlarge ?? large ?? medium ?? cozy ?? compact;
    }
  }
}

extension Rctx on BuildContext {
  AppSizeClass get sizeClass => AppResponsive.sizeClassOf(this);
  double get rScale => AppResponsive.scaleOf(this);
  double get rTextScale => AppResponsive.textScale(this);
  T r<T>({required T compact, T? cozy, T? medium, T? large, T? xlarge}) =>
      AppResponsive.value(
        this,
        compact: compact,
        cozy: cozy,
        medium: medium,
        large: large,
        xlarge: xlarge,
      );
}
