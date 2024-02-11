import 'dart:io';

import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class VerticalMenuDropDown extends StatefulWidget {
  @override
  _VerticalMenuDropDownState createState() => _VerticalMenuDropDownState();
}

class _VerticalMenuDropDownState extends State<VerticalMenuDropDown> {
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
        showDropdown(context, homeController.selectedBusiness);
      },
    );
  }
}

void showDropdown(BuildContext context, String businessId) async {
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
    String routeName =  result;
    // Navigate to the selected page using the route name
    if (routeName != null) {

      // print("This is route : $result");
      if(result == "Create Group"){
        GoRouter.of(context).pushNamed(MyAppRouteConstants.createGroupRouteName);
      }
      else if(result == "Refresh"){
        Provider.of<BusinessController>(context, listen: false).setBusinessModelNull();
        Provider.of<HomeProvider>(context, listen: false).setUserModelNull();
        GoRouter.of(context).goNamed(MyAppRouteConstants.splashscreenRouteName);
      }
      else if(result == "Requests"){
        Provider.of<BusinessRequestsProvider>(context, listen: false).clear();
        GoRouter.of(context).pushNamed(MyAppRouteConstants.businessRequestsRouteName,
            params: {"businessId": businessId});
      }
      else if(result == "Users"){
        print("Hi");
        GoRouter.of(context).pushNamed(MyAppRouteConstants.businessUsersListPageRouteName,
            params: {"businessId": businessId});
      }
      else if(result == "Closed Issues"){
        print("Hi");
        GoRouter.of(context).pushNamed(MyAppRouteConstants.closedIssuesPageRouteName);
      }
      else if(result == "Download Issue Template"){
        print("Hi");
        Provider.of<BusinessController>(context, listen: false).downloadCsvTemplate(context);
      }
      else if(result == "Upload Issues"){
        Provider.of<BusinessController>(context, listen: false).pickAndUploadCsvFile(context , businessId);
      }
      else if(result == "Share"){
        final businessModel = Provider.of<BusinessController>(context, listen: false).businessModel;

        String businessCode = businessModel!.business!.businessCode;
        Share.share("Use this code ${businessCode} to join our business and become a valued member!");
      }
    }
  }
}

List<String> menuItemsList = [
  "Refresh",
  "Requests",
  "Create Group",
  "Users",
  "Closed Issues",
  "Download Issue Template",
  "Upload Issues",
  "Share"
];

List<Map<String, String>> menuItemsWithRoutes = [
  {
    "Requests": MyAppRouteConstants.businessRequestsRouteName,
    "Create Group": MyAppRouteConstants.createGroupRouteName,
    "Users": MyAppRouteConstants.businessUsersListPageRouteName,
    "Closed Issues": MyAppRouteConstants.closedIssuesPageRouteName,
  },
];

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
