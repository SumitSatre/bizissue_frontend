import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VerticalMenuDropDownOfGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ViewGroupProvider>(
      builder: (context, homeController, viewGroupController, child) {
        final businessId = homeController.selectedBusiness;
        return CupertinoButton(
          child: Icon(
            CupertinoIcons.ellipsis_vertical,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            showDropdown(context, businessId, viewGroupController.deleteGroupRequest);
          },
        );
      },
    );
  }
}

void showDropdown(BuildContext context, String businessId, Function deleteGroup) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(0 - 15, button.size.height - 15), ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  final List<PopupMenuEntry<String>> menuItems = buildMenuItems(deleteGroup, businessId);

  final result = await showMenu(
    context: context,
    position: position,
    items: menuItems,
  );

  // Handle the selected menu item
  handleSelectedMenuItem(result, context, businessId, deleteGroup);
}

List<PopupMenuEntry<String>> buildMenuItems(Function deleteGroup, String businessId) {
  return [
    PopupMenuItem<String>(
      value: "Remove Users",
      child: Text("Remove Users"),
    ),
    PopupMenuItem<String>(
      value: "Add Users",
      child: Text("Add Users"),
    ),
    PopupMenuItem<String>(
      value: "Delete Group",
      child: Text("Delete Group"),
    ),
    // Add more items as needed
    // PopupMenuItem<String>(
    //   value: "Another Action",
    //   child: Text("Another Action"),
    // ),
  ];
}

void handleSelectedMenuItem(String? result, BuildContext context, String businessId, Function deleteGroup) {
  if (result == "Delete Group") {
    // Call the delete group function here
    deleteGroup(context, businessId);
  }
  else if(result == "Remove Users"){
    final viewGroupController = Provider.of<ViewGroupProvider>(context, listen: false);
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    viewGroupController.handleOnClickRemoveUsers(context);
  }
  else if(result == "Add Users"){
    final viewGroupController = Provider.of<ViewGroupProvider>(context, listen: false);
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    viewGroupController.handleOnClickAddUsers(context);
  }
  // Add more handling for other menu items if needed
}
