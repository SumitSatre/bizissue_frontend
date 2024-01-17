import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/widgets/view_issues_page.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupDetailedPage extends StatefulWidget {
  final String groupId;

  GroupDetailedPage({required this.groupId});

  @override
  _GroupDetailedPageState createState() => _GroupDetailedPageState();
}

class _GroupDetailedPageState extends State<GroupDetailedPage> {
  @override
  void initState() {
    super.initState();
    // Note: It's better to perform async operations in didChangeDependencies instead of initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callInit(
          Provider.of<HomeProvider>(context, listen: false).selectedBusiness);
    });
  }

  // Use late to indicate that these values will be initialized before they are used
  String todaysDate = getFormattedDate(DateTime.now());
  String tomorrowsDate =
      getFormattedDate(DateTime.now().add(Duration(days: 1)));

  void callInit(String businessId) async {
    final groupController = Provider.of<GroupProvider>(context, listen: false);
    await groupController.getGroupData(businessId, widget.groupId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // No need to create local variables for height and width unless you use them
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final groupController = Provider.of<GroupProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      body: groupController.groupSortedIssuesList != null
          ? ViewIssuesWidget(
              key: UniqueKey(), // Use UniqueKey to ensure a unique instance
              groupIssues: groupController.groupSortedIssuesList!,
            )
          : Center(child: CircularProgressIndicator()),
    ));
  }
}
