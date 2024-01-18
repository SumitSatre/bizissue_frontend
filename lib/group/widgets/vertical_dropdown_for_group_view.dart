import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VerticalMenuDropDownOfGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, GroupProvider>(
      builder: (context, homeController, groupController, child) {
        final businessId = homeController.selectedBusiness;
        return CupertinoButton(
          child: Icon(
            CupertinoIcons.ellipsis_vertical,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            showDropdown(context, businessId, groupController.deleteGroupRequest);
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

  final result = await showMenu(
    context: context,
    position: position,
    items: menuItemsList.map((String s) {
      return PopupMenuItem<String>(
        value: s,
        child: Text("  $s"),
      );
    }).toList(),
  );

  if (result != null) {
    if (result == "Delete Group") {
      // Call the delete group function here
      deleteGroup(context , businessId);
    }
  }
}

List<String> menuItemsList = [
  "Delete Group"
];

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
