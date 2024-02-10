import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
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
    ),
  );
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

List<IssueModel> filterIssues(
    List<IssueModel>? issues, String selectedBCDFilter) {
  switch (selectedBCDFilter) {
    case "Blocked":
      return issues?.where((issue) => issue.blocked.isBlocked == true).toList() ?? [];
    case "Critical":
      return issues?.where((issue) => issue.critical.isCritical == true).toList() ??
          [];
    case "Delayed":
      return issues?.where((issue) => issue.delayed >= 1).toList() ?? [];
    default:
      return issues ?? [];
  }
}

List<GroupIssue> groupAndSortIssues(List<IssueModel> issues) {
  // Group issues by nextFollowUpDate
  Map<String, List<IssueModel>> groupedIssues = {};

  issues.forEach((issue) {
    String key = issue.nextFollowUpDate ?? "";
    groupedIssues[key] = [...(groupedIssues[key] ?? []), issue];
  });

  List<GroupIssue> formattedIssues = groupedIssues.entries.map((entry) {
    return GroupIssue(
      date: entry.key,
      issues: entry.value,
    );
  }).toList();

  formattedIssues.sort((a, b) => a.date!.compareTo(b.date!));

  return formattedIssues;
}

List<GroupIssue> groupAndSortIssuesDeliveryDate(List<IssueModel> issues) {
  // Group issues by nextFollowUpDate
  Map<String, List<IssueModel>> groupedIssues = {};

  issues.forEach((issue) {
    String key = issue.deliveryDate ?? "";
    groupedIssues[key] = [...(groupedIssues[key] ?? []), issue];
  });

  List<GroupIssue> formattedIssues = groupedIssues.entries.map((entry) {
    return GroupIssue(
      date: entry.key,
      issues: entry.value,
    );
  }).toList();

  formattedIssues.sort((a, b) => a.date!.compareTo(b.date!));

  return formattedIssues;
}

List<UserListModel> removeUsersByIds(
    List<UserListModel> userList, List<String> idsToRemove) {
  return userList
      .where((user) => !idsToRemove.contains(user.userId))
      .toList();
}

List<UserListModel> selectUsersByIds(
    List<UserListModel> userList, List<String> idsToSelect) {
  return userList.where((user) => idsToSelect.contains(user.userId)).toList();
}

String convertUTCtoLocal(String utcTimeString) {
  // Parse the UTC time string
  DateTime utcTime = DateTime.parse(utcTimeString);

  // Convert to local time
  DateTime localTime = utcTime.toLocal();

  // Format the local time string including AM/PM indicator
  String formattedLocalTime = DateFormat('yyyy-MM-dd hh:mm:ss a').format(localTime);

  return formattedLocalTime;
}