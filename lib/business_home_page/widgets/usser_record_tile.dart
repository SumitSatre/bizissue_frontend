import 'package:bizissue/Issue/widgets/reassign_issue_dialog.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/change_manager_dialog.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/business_home_page/models/user_record_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_users_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';

class UserRecordTile extends StatelessWidget {
  final UserRecord userRecord;
  final BuildContext prevContext;

  UserRecordTile({required this.userRecord, required this.prevContext});

  @override
  Widget build(BuildContext context) {
    final businessUsersController =
        Provider.of<BusinessUsersProvider>(context, listen: true);
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final businessModel =
        Provider.of<BusinessController>(context).businessModel;
    return Card(
      elevation: 1, // Add elevation for a more attractive look
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: InkWell(
        onTap: () {
          print("Hello");
          String businessId = homeController.selectedBusiness;
          String userId = userRecord.userId;
          GoRouter.of(context).pushNamed(
            MyAppRouteConstants.userProfilePageRouteName,
            params: {
              "userId": userId,
              "businessId": businessId,
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userRecord.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('User Type: ${userRecord.userType}'),
                    Text('Role: ${userRecord.role}'),
                  ],
                ),
              ),
              if (userRecord.userType != "Outsider")
                SizedBox(
                  width: 40,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.ellipsis_vertical),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            actions: <Widget>[
                              if (businessModel!.user.role == 'Admin')
                                CupertinoActionSheetAction(
                                  child: Text('Promote to MiniAdmin'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    businessUsersController
                                        .promoteDemoteUserRequest(
                                      prevContext,
                                      homeController.selectedBusiness,
                                      "MiniAdmin",
                                      userRecord.userId,
                                    );
                                  },
                                ),
                              if (businessModel!.user.role == 'Admin')
                                CupertinoActionSheetAction(
                                  child: Text('Demote to User'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    businessUsersController
                                        .promoteDemoteUserRequest(
                                      prevContext,
                                      homeController.selectedBusiness,
                                      "User",
                                      userRecord.userId,
                                    );
                                  },
                                ),

                              if (businessModel!.user.role == 'Admin' ||
                                  businessModel!.user.role == 'MiniAdmin')
                                CupertinoActionSheetAction(
                                  child: Text('Remove User'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    businessUsersController
                                        .RemoveUserFromBusinessRequest(
                                      prevContext,
                                      homeController.selectedBusiness,
                                      userRecord.userId,
                                    );
                                  },
                                ),

                              if (businessModel!.user.role == 'Admin' ||
                                  businessModel!.user.role == 'MiniAdmin')
                                CupertinoActionSheetAction(
                                  child: Text('Change Manager'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    String businessId =
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .selectedBusiness;
                                    showDialog(
                                      context: context,
                                      builder: (context) => ChangeManagerDialog(
                                          userId: userRecord.userId,
                                          businessId: businessId,
                                          prevContext: prevContext),
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
              if (userRecord.userType == "Outsider")
                SizedBox(
                  width: 40,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.ellipsis_vertical),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            actions: <Widget>[
                              if (businessModel!.user.role == 'Admin' ||
                                  businessModel!.user.role == 'MiniAdmin')
                                CupertinoActionSheetAction(
                                  child: Text('Convert to insider'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    businessUsersController
                                        .convertOutsiderToInsiderRequest(
                                      prevContext,
                                      homeController.selectedBusiness,
                                      userRecord.userId
                                    );
                                  },
                                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
