import 'package:intl/intl.dart';

/// Utility class for formatting and parsing Rupiah (IDR) currency.
class CurrencyUtils {
  /// Format angka menjadi string Rupiah, contoh:
  /// ```dart
  /// CurrencyUtils.format(10000); // "Rp 10.000"
  /// ```
  static String format(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Parse string Rupiah menjadi angka (int).
  /// ```dart
  /// CurrencyUtils.parse("Rp 10.000"); // 10000
  /// ```
  static int parse(String formatted) {
    final cleaned = formatted.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}
