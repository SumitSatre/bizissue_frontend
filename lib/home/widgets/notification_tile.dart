import 'package:flutter/material.dart';
import 'package:bizissue/home/models/user_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format createdDate to DD/MM/YYYY
    String formattedDate = '${notification.createdDate.day.toString().padLeft(2, '0')}/'
        '${notification.createdDate.month.toString().padLeft(2, '0')}/'
        '${notification.createdDate.year}';

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          'Content: ${notification.content}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Category: ${notification.notificationCategory}',
            ),
            SizedBox(height: 4),
            Text(
              'Created Date: $formattedDate',
            ),
          ],
        ),
      ),
    );
  }
}
