import 'package:flutter/material.dart';

void showSnackBar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
      ),
    ),
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  ));
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

bool isValidDateFormat(String dateString) {
  // Regular expression for YYYY-MM-DD format with optional leading zeros for month and day
  RegExp regex = RegExp(r'^\d{4}-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-9]|3[01])$');

  // Test if the provided string matches the regular expression
  return regex.hasMatch(dateString);
}

String convertDateFormat(String inputDate) {
  // Split the input date into year, month, and day
  List<String> dateParts = inputDate.split('-');

  // Ensure year, month, and day are in two-digit format
  String year = dateParts[0].padLeft(4, '0');
  String month = dateParts[1].padLeft(2, '0');
  String day = dateParts[2].padLeft(2, '0');

  // Return the formatted date
  return '$year-$month-$day';
}

String getFormattedDate(DateTime date) {
  return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
}

String _twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  } else {
    return '0$n';
  }
}