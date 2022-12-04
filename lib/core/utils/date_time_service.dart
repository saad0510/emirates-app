class DateTimeService {
  static final minDate = DateTime(2000, 1, 1);
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

  static DateTime fromIsoString(String iso, {bool full = true}) {
    final year = int.parse(iso.substring(0, 4));
    final month = int.parse(iso.substring(5, 7));
    final day = int.parse(iso.substring(8, 10));
    int hour = 0;
    int min = 0;
    if (full) {
      hour = int.parse(iso.substring(11, 13));
      min = int.parse(iso.substring(14, 16));
    }
    return DateTime(year, month, day, hour, min);
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
