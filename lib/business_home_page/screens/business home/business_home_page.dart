import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/business_home_page/widgets/custom_expannsion_tile.dart';
import 'package:bizissue/business_home_page/widgets/empty_screen.dart';
import 'package:bizissue/business_home_page/widgets/issue_tile.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/business_activity_socket_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';

class BusinessHomePage extends StatefulWidget {
  final String id;

  const BusinessHomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {

  // late IO.Socket socket;

   @override
   void initState() {
     super.initState();
      // socket = BusinessActivitySocketService().socket;
   }

  void callInit() {
    Provider.of<BusinessController>(context, listen: false).init(widget.id);
  }

  String todaysDate = getFormattedDate(DateTime.now());
  String tomorrowsDate =
      getFormattedDate(DateTime.now().add(Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    final businessModel =
        Provider.of<BusinessController>(context).businessModel;

    if (businessModel == null) {
      callInit();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final userModel = Provider.of<HomeProvider>(context).userModel;

    return SafeArea(
      child:
          Consumer<BusinessController>(builder: (context, controller, child) {
        return controller.isError
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your token has expired.please login again"),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<BusinessController>(context,
                                  listen: false)
                              .updateisError();
                          SharedPreferenceService().clearLogin();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              MyAppRouteConstants.loginRouteName,
                              (route) => false);
                        },
                        child: const Text("Login  again"))
                  ],
                ),
              )
            : businessModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kprimaryColor,
                    ),
                  )
                : Scaffold(
                    body: RefreshIndicator(
                      onRefresh: () async {
                        controller.onRefresh(context);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Filters:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: width * 0.02,
                                ),

                                SizedBox(
                                  width: width * 0.45,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: ToggleSwitch(
                                        initialLabelIndex:
                                            controller.isSwitched ? 0 : 1,
                                        inactiveBgColor: kbackgroundColor,
                                        activeBgColor: [kprimaryColor],
                                        fontSize: 13,
                                        multiLineText: true,
                                        minWidth: width * 0.22,
                                        totalSwitches: 2,
                                        labels: ['My Issues', 'My Team Issues'],
                                        centerText: true,
                                        onToggle: (index) {
                                          if (index == 0) {
                                            controller.isSwitched = true;
                                          } else {
                                            controller.isSwitched = false;
                                          }
                                          controller.notifyListeners();
                                        },
                                      )),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 2),
                                Container(
                                  height: 36,
                                  width: width * 0.24,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      icon: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      elevation: 4,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      value: controller.selectedBCDFilter,
                                      onChanged: (p0) {
                                        if (p0 != null) {
                                          controller.selectedBCDFilter = p0;
                                          controller.notifyListeners();
                                        }
                                      },
                                      items:
                                          BCDList.map<DropdownMenuItem<String>>(
                                              (String s) {
                                        return DropdownMenuItem<String>(
                                          value: s,
                                          child: Text("  $s"),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: width * 0.01,
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.isSwitched
                                  ? controller.myIssuesGroup?.length ?? 0
                                  : controller.myTeamIssuesGroup?.length ?? 0,
                              itemBuilder: (context, index) {
                                GroupIssue groupIssue  = controller.isSwitched
                                    ? controller.myIssuesGroup![index]
                                    : controller.myTeamIssuesGroup![index];

                                if (groupIssue == null ||
                                    groupIssue.issues == null ||
                                    groupIssue.issues!.length < 1) {
                                  return Center(child: Text("No Data"));
                                } else {
                                  List<IssueModel> filteredIssues =
                                      filterIssues(groupIssue.issues,
                                          controller.selectedBCDFilter);

                                  if (filteredIssues.isEmpty) {
                                    return Container();
                                  }

                                  return CustomExpansionTile(
                                    title:
                                    groupIssue.nextFollowUpDate == todaysDate
                                            ? "Today"
                                            : groupIssue.nextFollowUpDate ==
                                                    tomorrowsDate
                                                ? "Tomorrow"
                                                : groupIssue.nextFollowUpDate ??
                                                    "No Date",
                                    issues: filteredIssues,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}


/*//    Container(
                                //        height: 36,
                                //        decoration: BoxDecoration(
                                //          border: Border.all(
                                //            style: BorderStyle.solid,
                                //            color: Colors.grey,
                                //          ),
                                //          borderRadius: BorderRadius.circular(12),
                                //        ),
                                //        child: Padding(
                                //          padding: const EdgeInsets.all(8.0),
                                //          child: Text(isSwitched
                                //              ? "My Issues"
                                //              : "MyTeamIssues"),
                                //        )), */