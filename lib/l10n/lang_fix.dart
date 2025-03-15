extension StringCaseExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Converts the string to uppercase.
  String toUpper() => toUpperCase();

  /// Converts the string to lowercase.
  String toLower() => toLowerCase();
}