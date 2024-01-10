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
