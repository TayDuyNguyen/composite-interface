import 'dart:math';

/// List extensions for collection utilities
extension ListExtensions<T> on List<T> {
  /// Get first element or null
  T? get firstOrNull => isNotEmpty ? first : null;

  /// Get last element or null
  T? get lastOrNull => isNotEmpty ? last : null;

  /// Remove duplicates from list
  List<T> removeDuplicates() => toSet().toList();

  /// Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    if (size <= 0) {
      throw ArgumentError('Size must be greater than 0');
    }
    final List<List<T>> chunks = [];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Shuffle list (returns new list)
  List<T> shuffleList() {
    final shuffled = List<T>.from(this)..shuffle();
    return shuffled;
  }

  /// Get random element from list
  T? get randomElement {
    if (isEmpty) {
      return null;
    }
    final random = Random();
    return this[random.nextInt(length)];
  }

  /// Check if all elements in list are equal
  bool get allEqual {
    if (isEmpty) {
      return true;
    }
    final firstItem = first;
    return every((element) => element == firstItem);
  }

  /// Get unique elements from list
  List<T> get uniqueElements => toSet().toList();

  /// Group list by key
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final Map<K, List<T>> groups = {};
    for (final T item in this) {
      final K key = keyFunction(item);
      groups[key] ??= [];
      groups[key]!.add(item);
    }
    return groups;
  }

  /// Sort list by key
  List<T> sortBy<K>(K Function(T) keyFunction, {bool ascending = true}) {
    final sorted = List<T>.from(this)
      ..sort((a, b) {
        final keyA = keyFunction(a);
        final keyB = keyFunction(b);
        if (keyA is Comparable && keyB is Comparable) {
          return ascending
              ? (keyA as Comparable).compareTo(keyB)
              : (keyB as Comparable).compareTo(keyA);
        }
        return 0;
      });
    return sorted;
  }

  /// Filter list by condition (alias for where().toList())
  List<T> filter(bool Function(T) condition) => where(condition).toList();

  /// Map list to another type (alias for map().toList())
  List<R> mapList<R>(R Function(T) transform) => map(transform).toList();

  /// Find first element that satisfies condition
  T? find(bool Function(T) condition) {
    try {
      return firstWhere(condition);
    } on Exception catch (_) {
      return null;
    }
  }

  /// Find index of first element that satisfies condition
  int? findIndex(bool Function(T) condition) {
    final index = indexWhere(condition);
    return index != -1 ? index : null;
  }

  /// Count elements that satisfy condition
  int count(bool Function(T) condition) => where(condition).length;

  /// Sum numeric values in list
  num sum(num Function(T) valueFunction) =>
      fold(0, (sum, item) => sum + valueFunction(item));

  /// Average numeric values in list
  double average(num Function(T) valueFunction) {
    if (isEmpty) {
      return 0;
    }
    return sum(valueFunction) / length;
  }

  /// Min value in list
  T? min(num Function(T) valueFunction) {
    if (isEmpty) {
      return null;
    }
    return reduce((a, b) => valueFunction(a) < valueFunction(b) ? a : b);
  }

  /// Max value in list
  T? max(num Function(T) valueFunction) {
    if (isEmpty) {
      return null;
    }
    return reduce((a, b) => valueFunction(a) > valueFunction(b) ? a : b);
  }
}
