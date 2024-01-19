import 'package:bizissue/business_home_page/models/group_short_model.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupTile extends StatelessWidget {
  final GroupShortModel group;
  final Color tileColor;

  const GroupTile({Key? key, required this.group, required this.tileColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tileColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Created Date: ${group.createdDate}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
