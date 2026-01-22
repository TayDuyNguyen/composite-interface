/// Numeric extensions
extension NumExtensions on num {
  /// Format bytes to human readable string
  String get fileSizeFormatted {
    if (this < 1024) {
      return '$this B';
    }
    if (this < 1024 * 1024) {
      return '${(this / 1024).toStringAsFixed(1)} KB';
    }
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
