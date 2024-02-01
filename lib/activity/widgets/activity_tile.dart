import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final ActivityModel activity;

  const ActivityTile({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${activity.activityCategory}: ${activity.content}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          _getSubtitle(),
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        trailing: Text(
          '${activity.createdDate}',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  String _getSubtitle() {
    if (activity.groupId != null && activity.groupName != null) {
      return 'Group: ${activity.groupName}, ID: ${activity.groupId}';
    } else if (activity.issueId != null && activity.issueTitle != null) {
      return 'Issue: ${activity.issueTitle}, ID: ${activity.issueId}';
    } else {
      return 'No details available';
    }
  }
}
