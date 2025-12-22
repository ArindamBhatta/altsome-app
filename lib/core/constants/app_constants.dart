class AppConstants {
  // API Base URLs
  static const String nhtsaBaseUrl = 'https://vpic.nhtsa.dot.gov/api/vehicles';

  // API Endpoints
  static const String getAllMakesEndpoint = '/GetAllMakes';
  static const String getModelsForMakeEndpoint = '/GetModelsForMake';
  static const String decodeVinEndpoint = '/DecodeVin';

  // API Parameters
  static const String jsonFormatParam = 'format=json';

  // Cache Keys
  static const String makesCacheKey = 'vehicle_makes_cache';
  static const String modelsCacheKey = 'vehicle_models_cache';
  static const int cacheExpirationHours = 24;

  // Dropdown Page Sizes
  static const int dropdownPageSize = 20;

  // Validation
  static const int vinLength = 17;

  // Error Messages
  static const String invalidVinError = 'Please enter a valid 17-character VIN';
  static const String networkTimeoutError =
      'Network is slow. Please try again.';
  static const String loadingMakesError = 'Failed to load vehicle makes';
  static const String loadingModelsError = 'Failed to load vehicle models';
  static const String initializationError =
      'Failed to initialize data. Please try again.';

  // Timeouts
  static const int apiTimeoutSeconds = 5;
  static const int shortTimeoutSeconds = 3;

  // UI Constants
  static const double dropdownMaxHeight = 300;
  static const double searchBarHeight = 56;
  static const double borderRadius = 8;

  // Colors (Add your color constants here)
  static const String darkBackgroundColor = '0xFF1E1E1E';
  static const String darkSurfaceColor = '0xFF2A2A2A';

  // Asset Paths
  static const String defaultVehicleImage = 'assets/images/default/mustang.png';
  static const String defaultAvatarImage =
      'assets/images/default/default_avatar.png';

  // Animation Durations
  static const int dropdownAnimationMs = 300;
  static const int loadingIndicatorMs = 1500;

  // Debounce Delays
  static const int searchDebounceMs = 500;
  static const int vinLookupDebounceMs = 500;
}

// Support Contact Information
// TODO: Replace with the actual support phone number
const String kSupportPhoneNumber = '+15551234567';
