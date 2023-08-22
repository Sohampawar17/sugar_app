class DateInputHelper {
  static String formatInput(String input) {
    String formatted = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (formatted.length > 4) {
      formatted = formatted.substring(0, 4) +
          '-' +
          formatted.substring(4, 6) +
          (formatted.length > 6 ? '-' + formatted.substring(6, 8) : '');
    }

    return formatted;
  }

  static bool isValidDate(String date) {
    if (date.length >= 10) {
      int year = int.tryParse(date.substring(0, 4)) ?? 0;
      int month = int.tryParse(date.substring(5, 7)) ?? 0;
      int day = int.tryParse(date.substring(8, 10)) ?? 0;

      if (year >= 1900 &&
          year <= 2100 &&
          month >= 1 &&
          month <= 12 &&
          day >= 1 &&
          day <= 31) {
        // Additional validation logic (e.g., for days in a month) can be added here
        return true;
      }
    }
    return false;
  }
}
