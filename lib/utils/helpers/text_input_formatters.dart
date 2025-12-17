import 'package:flutter/services.dart';

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digits
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 16 digits
    final limitedDigits =
        digitsOnly.length > 16 ? digitsOnly.substring(0, 16) : digitsOnly;

    // Add spaces every 4 digits
    final formatted = StringBuffer();
    for (var i = 0; i < limitedDigits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted.write(' ');
      }
      formatted.write(limitedDigits[i]);
    }

    final formattedText = formatted.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digits
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 4 digits (MMYY)
    final limitedDigits =
        digitsOnly.length > 4 ? digitsOnly.substring(0, 4) : digitsOnly;

    // Add slash after MM
    var formatted = '';
    for (var i = 0; i < limitedDigits.length; i++) {
      if (i == 2) {
        formatted += '/';
      }
      formatted += limitedDigits[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CVVFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digits and limit to 4 digits
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits =
        digitsOnly.length > 3 ? digitsOnly.substring(0, 3) : digitsOnly;

    return TextEditingValue(
      text: limitedDigits,
      selection: TextSelection.collapsed(offset: limitedDigits.length),
    );
  }
}
