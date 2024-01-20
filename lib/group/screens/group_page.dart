import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/group/widgets/group_tile.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart'; // Import your GroupShortModel class
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/utils/utils.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Set<String> selectedChats = Set<String>();

  bool isMultiSelectMode = false;

  void callInit(BuildContext context, String businessId) async {
    try {
      await Provider.of<GroupProvider>(context, listen: false)
          .getGroupsList(businessId)
          .then((_) {
        setState(() {});
      });
    } catch (error) {
      print('Error in callInit: $error');
      // here we can set userGroupsList as [] so screen stops circular widget
      showSnackBar(context, "Unable to fetch groups data!!", failureColor);
    }
  }

  @override
  void dispose() {
    // Provider.of<GroupProvider>(context, listen: false).dispose();
    // Provider.of<ViewGroupProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final groupController = Provider.of<GroupProvider>(context, listen: false);

    if (groupController.userGroupslist == null) {
      callInit(context, homeController.selectedBusiness);
    }

    return Scaffold(
      body: groupController.userGroupslist == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                groupController.clearGroupPageData();
                setState(() {});
              },
              child: ListView.builder(
                // physics: BouncingScrollPhysics(),
                itemCount: groupController.userGroupslist?.length ?? 0,
                itemBuilder: (context, index) {
                  String chat = groupController.userGroupslist![index].groupId;
                  bool isSelected = selectedChats.contains(chat);
                  GroupShortModel group =
                      groupController.userGroupslist![index];
                  return GestureDetector(
                      onLongPress: () {
                        setState(() {
                          isMultiSelectMode = true;
                          selectedChats.add(chat);
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (isMultiSelectMode) {
                            if (isSelected) {
                              selectedChats.remove(chat);
                              if (selectedChats.isEmpty) {
                                // If no chats are selected, exit multi-select mode
                                isMultiSelectMode = false;
                              }
                            } else {
                              selectedChats.add(chat);
                            }
                          } else {
                            Provider.of<ViewGroupProvider>(context, listen: false).setGroupDetailsNull();
                              GoRouter.of(context).pushNamed(MyAppRouteConstants.groupDetailedRouteName , params: {
                                "groupId" : group.groupId,
                                "groupName" : group.name
                              });
                          }
                        });
                      },
                      child: GroupTile(group: group , tileColor: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white)
                  );
                },
              ),
            ),
      bottomNavigationBar: selectedChats.isNotEmpty
          ? BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            final viewGroupController = Provider.of<ViewGroupProvider>(context, listen: false);

            viewGroupController.groupIds = selectedChats.toList();

            viewGroupController.groupNames = selectedChats.map((id) {
              var group = groupController.userGroupslist?.firstWhere(
                    (group) => group.groupId == id,
                orElse: () => GroupShortModel(groupId: '', name: 'Unknown', createdDate: ''),
              ) ?? GroupShortModel(groupId: '', name: 'Unknown', createdDate: '');

              return group.name;
            }).toList();

            GoRouter.of(context).pushNamed(MyAppRouteConstants.multipleGroupDetailedRouteName);
          },
          child: Text('View'),
        ),
      )
          : null,
    );
  }
}
