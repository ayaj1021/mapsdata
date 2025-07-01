import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toFormattedString() {
    return '$year-$month-$day';
  }

  String get dateOnly => toIso8601String().split('T').first;

  DateTime get splitDateOnly => DateTime.parse(toString().split(' ')[0]);

  String get toTime => DateFormat('hh:mm a').format(toLocal()).toLowerCase();

  String get toDate => DateFormat('MMM d, y').format(toLocal());

  String get getHeaderDate => day == DateTime.now().day
      ? 'Today'
      : day == DateTime.now().day - 1
          ? 'Yesterday'
          : DateFormat('MMM dd, yyyy').format(this);

  String get timeAgo {
    final difference = DateTime.now().difference(this);
    final days = difference.inDays;
    final hours = difference.inHours;
    final minutes = difference.inMinutes;
    final seconds = difference.inSeconds;
    if (days > 0) {
      return toDate;
    } else if (hours > 0) {
      return toTime;
    } else if (minutes > 0) {
      if (minutes == 1) {
        return '$minutes minute ago';
      }
      return '$minutes minutes ago';
    } else if (seconds > 0) {
      return '$seconds seconds ago';
    } else {
      return 'Just now';
    }
  }
}
