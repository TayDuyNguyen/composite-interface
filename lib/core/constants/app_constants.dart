/// Application constants
/// Contains all app-wide constants and configuration values
final class AppConstants {
  AppConstants._();

  // App Information
  /// Application name
  static const String appName = 'GoEdu';

  /// Application version
  static const String appVersion = '1.0.0';

  /// Application build number
  static const String appBuildNumber = '1';

  /// Application package name
  static const String appPackageName = 'com.goline.goedu';

  // API Constants
  /// API version
  static const String apiVersion = 'v1';

  /// API content type
  static const String apiContentType = 'application/json';

  /// API accept header
  static const String apiAcceptHeader = 'application/json';

  /// API user agent
  static const String apiUserAgent = 'GoEdu/1.0.0';

  // HTTP Status Codes
  /// HTTP 200 OK status code
  static const int httpOk = 200;

  /// HTTP 201 Created status code
  static const int httpCreated = 201;

  /// HTTP 204 No Content status code
  static const int httpNoContent = 204;

  /// HTTP 400 Bad Request status code
  static const int httpBadRequest = 400;

  /// HTTP 401 Unauthorized status code
  static const int httpUnauthorized = 401;

  /// HTTP 403 Forbidden status code
  static const int httpForbidden = 403;

  /// HTTP 404 Not Found status code
  static const int httpNotFound = 404;

  /// HTTP 405 Method Not Allowed status code
  static const int httpMethodNotAllowed = 405;

  /// HTTP 409 Conflict status code
  static const int httpConflict = 409;

  /// HTTP 422 Unprocessable Entity status code
  static const int httpUnprocessableEntity = 422;

  /// HTTP 429 Too Many Requests status code
  static const int httpTooManyRequests = 429;

  /// HTTP 500 Internal Server Error status code
  static const int httpInternalServerError = 500;

  /// HTTP 502 Bad Gateway status code
  static const int httpBadGateway = 502;

  /// HTTP 503 Service Unavailable status code
  static const int httpServiceUnavailable = 503;

  /// HTTP 504 Gateway Timeout status code
  static const int httpGatewayTimeout = 504;

  // Error Messages
  /// Network connection error message
  static const String errorNetworkConnection = 'Network connection error';

  /// Server error message
  static const String errorServerError = 'Server error occurred';

  /// Request timeout error message
  static const String errorTimeout = 'Request timeout';

  /// Unauthorized access error message
  static const String errorUnauthorized = 'Unauthorized access';

  /// Access forbidden error message
  static const String errorForbidden = 'Access forbidden';

  /// Resource not found error message
  static const String errorNotFound = 'Resource not found';

  /// Validation error message
  static const String errorValidation = 'Validation error';

  /// Unknown error message
  static const String errorUnknown = 'Unknown error occurred';

  // Validation Constants
  /// Minimum password length
  static const int minPasswordLength = 8;

  /// Maximum password length
  static const int maxPasswordLength = 128;

  /// Minimum name length
  static const int minNameLength = 2;

  /// Maximum name length
  static const int maxNameLength = 50;

  /// Minimum email length
  static const int minEmailLength = 5;

  /// Maximum email length
  static const int maxEmailLength = 255;

  /// Minimum phone length
  static const int minPhoneLength = 10;

  /// Maximum phone length
  static const int maxPhoneLength = 15;

  // Regex Patterns
  /// Email validation regex pattern
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Phone validation regex pattern
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';

  /// Password validation regex pattern
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  /// Name validation regex pattern
  static const String nameRegex = r'^[a-zA-Z\s]+$';

  // Storage Keys
  /// Access token storage key
  static const String keyAccessToken = 'access_token';

  /// Refresh token storage key
  static const String keyRefreshToken = 'refresh_token';

  /// User data storage key
  static const String keyUserData = 'user_data';

  /// App settings storage key
  static const String keySettings = 'app_settings';

  /// Theme mode storage key
  static const String keyTheme = 'theme_mode';

  /// Language storage key
  static const String keyLanguage = 'language';

  /// First launch storage key
  static const String keyFirstLaunch = 'first_launch';

  /// Onboarding completed storage key
  static const String keyOnboardingCompleted = 'onboarding_completed';

  /// Biometric authentication enabled storage key
  static const String keyBiometricEnabled = 'biometric_enabled';

  /// PIN code storage key
  static const String keyPinCode = 'pin_code';

  /// Helper for dynamic setting keys
  static String storageSettingKey(String key) => 'setting_$key';

  // Animation Durations
  /// Short animation duration
  static const Duration animationDurationShort = Duration(milliseconds: 200);

  /// Medium animation duration
  static const Duration animationDurationMedium = Duration(milliseconds: 300);

  /// Long animation duration
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // UI Constants
  /// Small border radius
  static const double borderRadiusSmall = 4.0;

  /// Medium border radius
  static const double borderRadiusMedium = 8.0;

  /// Large border radius
  static const double borderRadiusLarge = 12.0;

  /// Extra large border radius
  static const double borderRadiusXLarge = 16.0;

  /// Low elevation
  static const double elevationLow = 2.0;

  /// Medium elevation
  static const double elevationMedium = 4.0;

  /// High elevation
  static const double elevationHigh = 8.0;

  /// Small padding
  static const double paddingSmall = 8.0;

  /// Medium padding
  static const double paddingMedium = 16.0;

  /// Large padding
  static const double paddingLarge = 24.0;

  /// Extra large padding
  static const double paddingXLarge = 32.0;

  /// Small margin
  static const double marginSmall = 8.0;

  /// Medium margin
  static const double marginMedium = 16.0;

  /// Large margin
  static const double marginLarge = 24.0;

  /// Extra large margin
  static const double marginXLarge = 32.0;

  // Image Constants
  /// Image quality for compression
  static const double imageQuality = 0.8;

  /// Maximum image size in bytes (5MB)
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB

  /// Thumbnail size in pixels
  static const int thumbnailSize = 200;

  /// Avatar size in pixels
  static const int avatarSize = 100;

  // Pagination Constants
  /// Default page size for pagination
  static const int defaultPageSize = 20;

  /// Maximum page size for pagination
  static const int maxPageSize = 100;

  /// Minimum page size for pagination
  static const int minPageSize = 5;

  // Timeout Constants
  /// Short timeout duration
  static const Duration timeoutShort = Duration(seconds: 5);

  /// Medium timeout duration
  static const Duration timeoutMedium = Duration(seconds: 15);

  /// Long timeout duration
  static const Duration timeoutLong = Duration(seconds: 30);

  /// Extra long timeout duration
  static const Duration timeoutXLong = Duration(seconds: 60);

  // Retry Constants
  /// Maximum retry attempts
  static const int maxRetryAttempts = 3;

  /// Retry delay duration
  static const Duration retryDelay = Duration(seconds: 1);

  /// Retry backoff multiplier
  static const Duration retryBackoffMultiplier = Duration(seconds: 2);

  // Logging Constants
  /// Log file name
  static const String logFileName = 'app.log';

  /// Maximum log file size in bytes (10MB)
  static const int maxLogFileSize = 10 * 1024 * 1024; // 10MB

  /// Maximum number of log files
  static const int maxLogFiles = 5;

  // Database Constants
  /// Database name
  static const String databaseName = 'app_database';

  /// Database version
  static const int databaseVersion = 1;

  /// Maximum database size in bytes (100MB)
  static const int maxDatabaseSize = 100 * 1024 * 1024; // 100MB

  // Security Constants
  /// Encryption key length in bytes
  static const int encryptionKeyLength = 32;

  /// HMAC key length in bytes
  static const int hmacKeyLength = 64;

  /// Salt length in bytes
  static const int saltLength = 16;

  /// Number of iterations for key derivation
  static const int iterations = 10000;

  // Theme Constants
  /// Light theme
  static const String themeLight = 'light';

  /// Dark theme
  static const String themeDark = 'dark';

  /// System theme
  static const String themeSystem = 'system';

  // Language Constants
  /// English language code
  static const String languageEnglish = 'en';

  /// Vietnamese language code
  static const String languageVietnamese = 'vi';

  /// Default language code
  static const String languageDefault = 'en';

  // Platform Constants
  /// Android platform
  static const String platformAndroid = 'android';

  /// iOS platform
  static const String platformIOS = 'ios';

  /// Web platform
  static const String platformWeb = 'web';

  /// Windows platform
  static const String platformWindows = 'windows';

  /// macOS platform
  static const String platformMacOS = 'macos';

  /// Linux platform
  static const String platformLinux = 'linux';

  // Network Constants
  /// WiFi network type
  static const String networkWifi = 'wifi';

  /// Mobile network type
  static const String networkMobile = 'mobile';

  /// Ethernet network type
  static const String networkEthernet = 'ethernet';

  /// No network connection
  static const String networkNone = 'none';

  // File Constants
  /// Allowed image file types
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp'
  ];

  /// Allowed document file types
  static const List<String> allowedDocumentTypes = [
    'pdf',
    'doc',
    'docx',
    'txt'
  ];

  /// Allowed video file types
  static const List<String> allowedVideoTypes = ['mp4', 'avi', 'mov', 'wmv'];

  // Date Format Constants
  /// Default date format
  static const String dateFormatDefault = 'yyyy-MM-dd';

  /// Display date format
  static const String dateFormatDisplay = 'MMM dd, yyyy';

  /// Time format
  static const String dateFormatTime = 'HH:mm:ss';

  /// Date and time format
  static const String dateFormatDateTime = 'yyyy-MM-dd HH:mm:ss';

  /// ISO date format
  static const String dateFormatISO = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

  // Currency Constants
  /// Default currency code
  static const String currencyDefault = 'USD';

  /// Currency symbol
  static const String currencySymbol = r'$';

  /// Currency decimal places
  static const int currencyDecimalPlaces = 2;

  // Measurement Constants
  /// Default font size
  static const double defaultFontSize = 14.0;

  /// Small font size
  static const double smallFontSize = 12.0;

  /// Large font size
  static const double largeFontSize = 16.0;

  /// Extra large font size
  static const double xLargeFontSize = 18.0;

  /// Extra extra large font size
  static const double xxLargeFontSize = 20.0;

  // Grid Constants
  /// Mobile grid columns
  static const int gridColumnsMobile = 2;

  /// Tablet grid columns
  static const int gridColumnsTablet = 3;

  /// Desktop grid columns
  static const int gridColumnsDesktop = 4;

  /// Grid spacing
  static const double gridSpacing = 16.0;

  // List Constants
  /// List item height
  static const int listItemHeight = 56;

  /// Large list item height
  static const int listItemHeightLarge = 72;

  /// Small list item height
  static const int listItemHeightSmall = 48;

  // Button Constants
  /// Button height
  static const double buttonHeight = 48.0;

  /// Small button height
  static const double buttonHeightSmall = 36.0;

  /// Large button height
  static const double buttonHeightLarge = 56.0;

  /// Button minimum width
  static const double buttonMinWidth = 88.0;

  // Input Constants
  /// Input field height
  static const double inputHeight = 48.0;

  /// Small input field height
  static const double inputHeightSmall = 40.0;

  /// Large input field height
  static const double inputHeightLarge = 56.0;

  /// Maximum lines for multiline input
  static const int maxLines = 5;

  /// Maximum length for input text
  static const int maxLength = 1000;

  // Card Constants
  /// Card elevation
  static const double cardElevation = 2.0;

  /// Card border radius
  static const double cardBorderRadius = 8.0;

  /// Card padding
  static const double cardPadding = 16.0;

  // Dialog Constants
  /// Dialog border radius
  static const double dialogBorderRadius = 12.0;

  /// Dialog padding
  static const double dialogPadding = 24.0;

  /// Dialog maximum width
  static const double dialogMaxWidth = 400.0;

  // Snackbar Constants
  /// Snackbar duration
  static const Duration snackbarDuration = Duration(seconds: 3);

  /// Long snackbar duration
  static const Duration snackbarDurationLong = Duration(seconds: 5);

  // Loading Constants
  /// Loading delay duration
  static const Duration loadingDelay = Duration(milliseconds: 500);

  /// Loading timeout duration
  static const Duration loadingTimeout = Duration(seconds: 30);

  // Refresh Constants
  /// Refresh timeout duration
  static const Duration refreshTimeout = Duration(seconds: 10);

  /// Refresh cooldown duration
  static const Duration refreshCooldown = Duration(seconds: 1);

  // Search Constants
  /// Search debounce duration
  static const Duration searchDebounce = Duration(milliseconds: 300);

  /// Minimum search length
  static const int searchMinLength = 2;

  /// Maximum search length
  static const int searchMaxLength = 100;

  // Contact Constants
  /// Support email address
  static const String supportEmail = 'support@example.com';

  /// Support phone number
  static const String supportPhone = '+1-555-0123';

  /// Support address
  static const String supportAddress = '123 Main St, City, State 12345';
}
