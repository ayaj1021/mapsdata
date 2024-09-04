
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

extension StringExtensions on String {
  String get redactedEmail {
    final parts = split('@');
    final firstPart = parts.first;
    //replace all characters except the first and last 2 characters with *
    final redacted = firstPart
        .substring(0, firstPart.length - 2)
        .replaceAll(RegExp('.'), '*');
    return '$redacted@${parts.last}';
  }

  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  dynamic removeSpecialCharacters({
    String currency = '₦',
    bool asString = true,
  }) {
    final v = replaceAll(',', '')
        .replaceAll(RegExp(r'[^\d\s.-]'), '')
        .replaceAll(currency, '');

    return asString ? v : double.tryParse(v) ?? 0;
  }

  String reArrangeDOB(String pattern, [String newPattern = '-']) {
    return split(pattern).reversed.join(newPattern);
  }
}

extension St on String? {
  DateTime? get toNormalDate {
    if (this == null) {
      return null;
    }
    final data = DateTime.parse(this!).toLocal();
    if (this != null) {
      return data;
    }
    return null;
  }

  //create string like this from date
  //9:32 am, Jun 17, 2024
  String get toTimeDate {
    if (this == null) {
      return '';
    }
    final data = DateFormat('hh:mm a, MMM d, y').format(DateTime.parse(this!));
    if (this != null) {
      return data;
    }
    return '';
  }

  String get toTime {
    if (this == null) {
      return '';
    }
    final data = DateFormat('hh:mm a').format(DateTime.parse(this!));
    if (this != null) {
      return data;
    }
    return '';
  }
}

extension StatusExtension on String {
  Color get statusColor => switch (toLowerCase()) {
        'success' || 'successful' => AppColors.green,
        'pending' => AppColors.secondaryColor,
        'failed' => AppColors.red,
        _ => AppColors.primaryColor,
      };
}
