
import 'package:mapsdata/core/extensions/validation_extension.dart';

/// A collection of common validators that can be reused
class Validators {
  static final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    '[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}'
    r'[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}'
    r'[a-zA-Z0-9])?)+\s*$',
  );

  static Validator notEmpty() {
    return (String? value) {
      return (value?.isEmpty ?? true) ? 'This field can not be empty.' : null;
    };
  }

  static String? confirmPass(String? value, String val) {
    if (value == null) {
      return null;
    }
    if (value != val) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  static Validator phone() {
    return (String? value) {
      final phoneNoReg = RegExp(r'^(09|07|08)\d{9}$');
      if (value?.isEmpty ?? false) {
        return 'This field can not be empty.';
      }
      return (!phoneNoReg.hasMatch(value!)) ? 'Invalid phone.' : null;
    };
  }

  static String? phoneNumberValidator(String value) {
    // Remove any whitespace characters from the phone number
    final sanitizedValue = value.replaceAll(RegExp(r'\s+'), '');

    // Define regular expressions for each country's phone number format
    final nigeriaRegExp = RegExp(r'^234(9|7|8|[7-9])\d{9}$');

    // Validate the phone number based on the country

    if (!nigeriaRegExp.hasMatch('234$sanitizedValue')) {
      return 'Invalid Nigerian phone number';
    }

    // Return null if the phone number is valid
    return null;
  }

  static Validator withdrawSafe(num safeAmount) {
    return (value) {
      if (value == null) {
        return 'This field can not be empty.';
      }
      if (num.parse(value) > safeAmount) {
        return "You can't withdraw more than your safe lock balance";
      }
      return null;
    };
  }

  static Validator date() {
    return (String? input) {
      // Remove any non-numeric characters from the input
      final numericInput = input!.replaceAll(RegExp(r'\D'), '');

      // Validate the length of the numeric input
      if (numericInput.length != 8) {
        return 'Invalid date';
      }

      // Extract the day, month, and year components
      final day = int.tryParse(numericInput.substring(0, 2));
      final month = int.tryParse(numericInput.substring(2, 4));
      final year = int.tryParse(numericInput.substring(4, 8));

      // Validate the day, month, and year components
      if (day == null || month == null || year == null) {
        return 'Invalid date';
      }

      if (day > 29 && month == 2) {
        return 'Invalid february date';
      }

      // Validate the date components
      if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900) {
        return 'Invalid date';
      }

      // Additional validation logic can be added if needed

      return null;
    };
  }

  static Validator name() {
    return (String? value) {
      if (value!.isEmpty) {
        return 'Field cannot be empty.';
      }
      return null;
    };
  }

  static Validator accountNumber() {
    return (String? value) {
      return (value!.length < 10) ? 'Invalid account number.' : null;
    };
  }

  static Validator minLength(int minLength) {
    return (String? value) {
      if ((value?.length ?? 0) < minLength) {
        return 'Must contain a minimum of $minLength characters.';
      }
      return null;
    };
  }

  static bool isValid(String pin, String pin2) =>
      pin.isNotEmpty && pin2.isNotEmpty && pin == pin2;
  static Validator matchPattern(Pattern pattern, [String? patternName]) {
    return (String? value) {
      if (value == null || (pattern.allMatches(value).isEmpty)) {
        return "Please enter a valid ${patternName ?? "value"}.";
      }
      return null;
    };
  }

  static Validator email() {
    return matchPattern(emailPattern, 'email');
  }

  static Validator password([int minimumLength = 8]) => multiple(
        [
          containsUpper('Password'),
          containsLower('Password'),
          containsNumber('Password'),
          containsSpecialChar('Password'),
          minLength(minimumLength),
        ],
        shouldTrim: false,
      );

  static Validator containsUpper([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsUpper()) return null;
      return '''${fieldName ?? 'Field'} must contain at least one uppercase character.''';
    };
  }

  static Validator containsLower([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsLower()) return null;
      return '''${fieldName ?? 'Field'} must contain at least one lowercase character.''';
    };
  }

  static Validator containsNumber([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsNumber()) return null;
      return "${fieldName ?? 'Field'} must contain at least one number.";
    };
  }

  static Validator containsSpecialChar([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsSpecialChar()) return null;
      return '''${fieldName ?? 'Field'} must contain at least one special character.''';
    };
  }

  /// Creates a validator that if the combination of multiple validators.
  ///
  /// The provided validators are applied in the order in which
  /// they're specified in the list.
  static Validator multiple(
    List<Validator> validators, {
    bool shouldTrim = true,
  }) {
    return (String? value) {
      value = shouldTrim ? value?.trim() : value;
      for (final validator in validators) {
        if (validator(value) != null) {
          return validator(value);
        }
      }
      return null;
    };
  }
}

typedef Validator = String? Function(String? value);
