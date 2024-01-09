import 'package:flutter/cupertino.dart';

class CreateIssueProvider extends ChangeNotifier {
  Future<void> performTask() async {
    // Simulating a time-consuming task
    await Future.delayed(Duration(seconds: 2));
  }
}