import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/business_home_page/models/user_record_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_users_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';

class UserRecordTile extends StatelessWidget {
  final UserRecord userRecord;

  UserRecordTile({required this.userRecord});

  @override
  Widget build(BuildContext context) {
    final businessUsersController =
    Provider.of<BusinessUsersProvider>(context, listen: true);
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    return ListTile(
      title: Text(userRecord.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User ID: ${userRecord.userId}'),
          Text('User Type: ${userRecord.userType}'),
          Text('Role: ${userRecord.role}'),
        ],
      ),
      trailing: userRecord.userType == "Outsider"
          ? SizedBox(height: 10,width: 10,)
          : SizedBox(
        width: 40, // Adjust the width as needed
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.ellipsis_vertical),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text('Promote to MiniAdmin'),
                      onPressed: () {
                        Navigator.pop(context);
                        businessUsersController.promoteDemoteUserRequest(
                          context,
                          homeController.selectedBusiness,
                          "MiniAdmin",
                          userRecord.userId,
                        );
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Demote to User'),
                      onPressed: () {
                        Navigator.pop(context);
                        businessUsersController.promoteDemoteUserRequest(
                          context,
                          homeController.selectedBusiness,
                          "User",
                          userRecord.userId,
                        );
                      },
                    ),
                    // Add more options as needed
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text('Cancel'),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );

  }
}
