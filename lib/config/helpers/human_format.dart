import 'package:intl/intl.dart';

class HumanFormat {
  static String number( double number ) {
    final format = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);

    return format;
  }
}