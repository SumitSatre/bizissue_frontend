import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/widgets/view_issues_page.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/group/widgets/vertical_dropdown_for_group_view.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MultipleGroupDetailedPage extends StatefulWidget {

  @override
  _MultipleGroupDetailedPageState createState() => _MultipleGroupDetailedPageState();
}

class _MultipleGroupDetailedPageState extends State<MultipleGroupDetailedPage> {
  String combinedNames = "";

  @override
  void initState() {
    super.initState();
    // Note: It's better to perform async operations in didChangeDependencies instead of initState
    Provider.of<ViewGroupProvider>(context, listen: false).clearGroupViewData();
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
    final viewGroupController = Provider.of<ViewGroupProvider>(context, listen: false);
    await viewGroupController.getMultipleGroupsData(businessId, viewGroupController.groupNames ?? []);
    combinedNames = viewGroupController.groupNames?.join(', ') ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // No need to create local variables for height and width unless you use them
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final viewGroupController = Provider.of<ViewGroupProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.19),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x1E000000),
                              blurRadius: 4,
                              offset: Offset(-3, 3),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            // issueController.clearData();
                            GoRouter.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        combinedNames ?? "Error",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  VerticalMenuDropDownOfGroupView()
                ],
              ),
            ),
          ),
          body: viewGroupController.groupSortedIssuesList != null
              ? ViewIssuesWidget(
            key: UniqueKey(), // Use UniqueKey to ensure a unique instance
            groupIssues: viewGroupController.groupSortedIssuesList!,
          )
              : Center(child: CircularProgressIndicator()),
        ));
  }
}