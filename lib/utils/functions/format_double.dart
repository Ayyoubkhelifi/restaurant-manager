import 'package:intl/intl.dart';

// e.g., formatter.format(1234567) => '1.234.567'
String formatDouble(double value) {
  final formatter = NumberFormat('#,##0', 'de_DE');
  final formatterDecimal = NumberFormat('#,##0.00', 'de_DE');

  if (value % 1 == 0) {
    // Integer value
    return formatter.format(value.toInt());
  } else {
    // Has decimals
    return formatterDecimal.format(value);
  }
}
