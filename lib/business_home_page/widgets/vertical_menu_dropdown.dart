import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VeriticalMenuDropDown extends StatefulWidget {
  @override
  _VeriticalMenuDropDownState createState() => _VeriticalMenuDropDownState();
}

class _VeriticalMenuDropDownState extends State<VeriticalMenuDropDown> {
  late String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.black,
        size: 25,
      ),
      onPressed: () {
        showDropdown(context , homeController.selectedBusiness);
      },
    );
  }
}

void showDropdown(BuildContext context , String businessId) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(0-15, button.size.height-15), ancestor: overlay),
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
    String? routeName = menuItemsWithRoutes.firstWhereOrNull(
          (item) => item.containsKey(result),
    )?[result!];

    // Navigate to the selected page using the route name
    if (routeName != null) {
      print("This is route : ${routeName}");
      GoRouter.of(context).pushNamed(MyAppRouteConstants.businessRequestsRouteName , params: {
        "businessId" : businessId
      });
    }
  }
}
List<String> menuItemsList = [
  "Requests"
];

List<Map<String , String>> menuItemsWithRoutes = [
  {
    "Requests" : MyAppRouteConstants.businessRequestsRouteName
  }
];

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
