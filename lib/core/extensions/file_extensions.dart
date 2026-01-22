import 'dart:io';

import 'package:myapp/core/constants/app_constants.dart';

/// File path string extensions
extension FilePathExtensions on String {
  /// Get file extension from path
  String get fileExtension => split('.').last.toLowerCase();

  /// Check if path is image file
  bool get isImageFile =>
      AppConstants.allowedImageTypes.contains(fileExtension);

  /// Check if path is document file
  bool get isDocumentFile =>
      AppConstants.allowedDocumentTypes.contains(fileExtension);

  /// Check if path is video file
  bool get isVideoFile =>
      AppConstants.allowedVideoTypes.contains(fileExtension);

  /// Check if file exists at path
  bool get fileExists => File(this).existsSync();

  /// Get file size in bytes
  int get fileSize {
    try {
      return File(this).lengthSync();
    } on Exception catch (_) {
      return 0;
    }
  }

  /// Delete file if exists
  void deleteFileIfExists() {
    try {
      final file = File(this);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } on Exception catch (_) {
      // Handle error or log
    }
  }

  /// Create directory if it doesn't exist
  void createDirectoryIfNotExists() {
    try {
      final directory = Directory(this);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
    } on Exception catch (_) {
      // Handle error
    }
  }
}

/// File extensions
extension FileExtensions on File {
  /// Copy file to destination path
  bool copyTo(String destinationPath) {
    try {
      // Create destination directory if it doesn't exist
      File(destinationPath).parent.createSync(recursive: true);
      copySync(destinationPath);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Move file to destination path
  bool moveTo(String destinationPath) {
    try {
      // Create destination directory if it doesn't exist
      File(destinationPath).parent.createSync(recursive: true);
      renameSync(destinationPath);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
