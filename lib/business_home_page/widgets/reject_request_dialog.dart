import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/home/models/user_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DenyLeaveRequestDialog extends StatelessWidget {
  final String userId;
  final String name;
  final ContactNumber contactNumber;

  DenyLeaveRequestDialog(
      {required this.userId, required this.name, required this.contactNumber});

  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deny Request'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Reason for Denial:'),
          TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            String denialReason = _reasonController.text;

            String businessId =
                Provider.of<HomeProvider>(context, listen: false)
                    .selectedBusiness;
            await Provider.of<BusinessRequestsProvider>(context, listen: false)
                .rejectRequestPost(
                    context, businessId, name, contactNumber, userId, denialReason);

            GoRouter.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
