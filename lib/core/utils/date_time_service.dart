class DateTimeService {
  static final minDate = DateTime(2020, 1, 1);
  static final maxDate = DateTime(2030, 12, 31);

  static String timeStr(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String dateStr(DateTime dateTime) {
    final year = dateTime.year.toString();
    final month = _monthStr(dateTime.month);
    final day = dateTime.day.toString();
    return '$month $day, $year';
  }

  static String dateTimeStr(DateTime dateTime, {bool full = false}) {
    final month = _monthStr(dateTime.month);
    final day = dateTime.day.toString();
    final year = !full ? '' : ', ${dateTime.year}';
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$month $day$year\t\t\t\t$hour:$minute';
  }

  static String _monthStr(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '---';
    }
  }
}
