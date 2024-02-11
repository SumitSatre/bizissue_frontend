import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RemoveOutsiderDialog extends StatelessWidget {
  final BuildContext prevContext;
  final IssueModel issue; // Information of the outsider

  RemoveOutsiderDialog({required this.prevContext, required this.issue});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final issueController = Provider.of<IssueProvider>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Outsider Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Display outsider information if available
            if (issue.outsider != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${issue.outsider!.name}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Contact Number: +${issue.outsider!.contactNumber?.countryCode ?? ''} ${issue.outsider!.contactNumber?.number ?? ''}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: height * 0.02),
                  // Button to remove the outsider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              kprimaryColor, // Change the background color to blue
                        ),
                        onPressed: () {
                          // Add logic to remove the outsider
                          // You can use Provider or any other method to handle this logic
                        },
                        child: Text("Close"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              kprimaryColor, // Change the background color to blue
                        ),
                        onPressed: () {
                          GoRouter.of(context).pop();
                          String businessId =
                              Provider.of<HomeProvider>(context, listen: false)
                                  .selectedBusiness;
                          issueController.removeOutsiderRequest(prevContext,
                              businessId, issue.outsider!.contactNumber!);
                          GoRouter.of(context).pop();
                        },
                        child: Text("Remove"),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
