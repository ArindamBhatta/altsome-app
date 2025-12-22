import 'package:altsome_app/core/widgets/conditional_widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:altsome_app/core/constants/app_constants.dart';
import 'package:altsome_app/core/utils/app_logger.dart';

/// **ImageUtils - Safe Image Loading Utility**
///
/// This utility class provides bulletproof image loading methods that prevent
/// common crashes and provide consistent fallback behavior across the app.
///
/// **🚨 IMPORTANT: Always use ImageUtils for image loading instead of raw Image widgets**
///
/// ## Key Benefits:
/// - Prevents crashes from null/invalid URLs
/// - Provides consistent fallback behavior
/// - Handles network failures gracefully
/// - Shows appropriate loading states
/// - Centralizes image loading logic
///
/// ## Usage Examples:
/// ```dart
/// // For user avatars (recommended)
/// ImageUtils.buildSafeCircleAvatar(
///   radius: 20,
///   imageUrl: user.profileImageUrl,
/// )
///
/// // For general images
/// ImageUtils.buildSafeImage(
///   imageUrl: vehicle.imageUrl,
///   width: 200,
///   height: 150,
/// )
/// ```
class ImageUtils {
  /// Creates a safe CircleAvatar with comprehensive error handling.
  static Widget buildSafeCircleAvatar({
    required double radius,
    String? imageUrl,
    String? fallbackAsset,
    Color? backgroundColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[300],
      backgroundImage: conditionalImageProvider(
        imageUrl,
        fallback: AssetImage(fallbackAsset ?? AppConstants.defaultAvatarImage),
      ),
      onBackgroundImageError: (exception, stackTrace) {
        AppLogger.logger.e(
          'Failed to load avatar image',
          error: exception,
          stackTrace: stackTrace,
        );
      },
      child: _buildFallbackIcon(radius),
    );
  }

  /// Creates a safe Image widget with proper error handling
  static Widget buildSafeImage({
    String? imageUrl,
    String? fallbackAsset,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image(
      image: conditionalImageProvider(
        imageUrl,
        fallback: AssetImage(fallbackAsset ?? AppConstants.defaultAvatarImage),
      ),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        AppLogger.logger.e(
          'Failed to load image: $imageUrl',
          error: error,
          stackTrace: stackTrace,
        );
        // Fallback to a placeholder if the image fails
        return _buildAssetFallback(
          fallbackAsset ?? AppConstants.defaultVehicleImage,
          width: width,
          height: height,
          fit: fit,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  /// Builds asset image with error handling
  static Widget _buildAssetFallback(
    String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        AppLogger.logger.e(
          'Failed to load asset image: $assetPath',
          error: error,
          stackTrace: stackTrace,
        );
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Icon(
            Icons.broken_image_outlined,
            size: (width != null && height != null)
                ? (width < height ? width : height) * 0.5
                : 24,
            color: Colors.grey[600],
          ),
        );
      },
    );
  }

  /// Builds fallback icon for CircleAvatar
  static Widget? _buildFallbackIcon(double radius) {
    return Icon(
      Icons.person,
      size: radius * 0.8,
      color: Colors.grey[600],
    );
  }
}
