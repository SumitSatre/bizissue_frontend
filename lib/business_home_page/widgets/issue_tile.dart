import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomIssueTile extends StatelessWidget {
  final IssueModel issue; // Replace 'Issue' with the actual class/type of your 'issue' object

  CustomIssueTile({required this.issue});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeProvider>(context, listen: false);
    return InkWell(
      onTap: (){
        Provider.of<IssueProvider>(context, listen: false).setIssueModelNull();
        GoRouter.of(context).pushNamed(MyAppRouteConstants.issuePageRouteName , params : {
          'issueId' : issue.issueId,
          "businessId" : controller.selectedBusiness
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Submitted by: Sumit",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${issue.nextFollowUpDate.toString()}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                // Add any other widgets or icons you may need
              ],
            ),
          ],
        ),
      ),
    );
  }
}
