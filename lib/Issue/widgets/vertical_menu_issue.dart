import 'package:bizissue/Issue/widgets/inivite_outsider_dialog.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VerticalMenuIssueDropDown extends StatefulWidget {
  final String issueId;

  VerticalMenuIssueDropDown({required this.issueId});

  @override
  _VerticalMenuDropDownState createState() => _VerticalMenuDropDownState();
}

class _VerticalMenuDropDownState extends State<VerticalMenuIssueDropDown> {
  late String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return CupertinoButton(
      child: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.black,
        size: 25,
      ),
      onPressed: () {
        showDropdown(context, widget.issueId);
      },
    );
  }
}

void showDropdown(
    BuildContext context, String issueId) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(0 - 15, button.size.height - 15),
          ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
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
    print("This is result : $result");

    if (result == "Invite outsider") {
      print("Opened");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // Return the dialog widget
          return InviteOutsiderDialog(issueId: issueId);
        },
      );
    }
  }
}

List<String> menuItemsList = ["Invite outsider"];

List<Map<String, String>> menuItemsWithRoutes = [
  {"Requests": MyAppRouteConstants.businessRequestsRouteName},
];

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
