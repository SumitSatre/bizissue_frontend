import 'package:bizissue/business_home_page/widgets/view_issues_page.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/group/widgets/vertical_dropdown_for_group_view.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GroupDetailedPage extends StatefulWidget {
  final String groupId;
  final String groupName;

  GroupDetailedPage({
    required this.groupId,
    required this.groupName,
  });

  @override
  _GroupDetailedPageState createState() => _GroupDetailedPageState();
}

class _GroupDetailedPageState extends State<GroupDetailedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callInit(
        Provider.of<HomeProvider>(context, listen: false).selectedBusiness,
      );
    });
  }

  Future<void> callInit(String businessId) async {
    try {

      final groupController = context.read<ViewGroupProvider>();
      await groupController.getGroupData(businessId, widget.groupId);
    } catch (e) {
      // Handle errors as needed
      print("Error in callInit: $e");
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.19),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
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
                          GoRouter.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      widget.groupName ?? "Error",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                VerticalMenuDropDownOfGroupView(),
              ],
            ),
          ),
        ),
        body: Consumer<ViewGroupProvider>(
          builder: (context, groupController, _) {
            return groupController.groupSortedIssuesList != null
                ? ViewIssuesWidget(
              key: UniqueKey(),
              groupIssues: groupController.groupSortedIssuesList!,
            )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
