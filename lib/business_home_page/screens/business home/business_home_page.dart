import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/business_home_page/widgets/custom_expannsion_tile.dart';
import 'package:bizissue/business_home_page/widgets/issue_tile.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';

class BusinessHomePage extends StatefulWidget {
  final String id;

  const BusinessHomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   callInit();
  // }

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
                      // await controller.onRefresh();
                      //  setState(() {
                      //  });
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Filters:"),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                            //    Container(
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
                            //        )),
                                SizedBox(
                                  width: width*0.51,
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:ToggleSwitch(
                                          initialLabelIndex: controller.isSwitched
                                              ? 0
                                              : 1,
                                          fontSize: 13,
                                          multiLineText: true,
                                          minWidth: width*0.25,
                                          totalSwitches: 2,
                                          labels: ['My Issues', 'My Team Issues'],
                                          onToggle: (index) {
                                            if(index == 0){
                                              controller.isSwitched = true;
                                            }
                                            else{
                                              controller.isSwitched = false;
                                            }
                                            controller.notifyListeners();
                                          },
                                        )

                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 5),
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.isSwitched ? businessModel.myIssues.length : businessModel.myTeamIssues.length ,
                              itemBuilder: (context, index) {
                                TeamIssue teamIssue = controller.isSwitched ? businessModel.myIssues[index] :
                                    businessModel.myTeamIssues[index];

                                List<IssueShort> filteredIssues = filterIssues(
                                    teamIssue.issues,
                                    controller.selectedBCDFilter);

                                if (filteredIssues.isEmpty) {
                                  return Container();
                                }

                                return CustomExpansionTile(
                                  title: teamIssue.nextFollowUpDate == todaysDate
                                      ? "Today"
                                      : teamIssue.nextFollowUpDate ==
                                              tomorrowsDate
                                          ? "Tomorrow"
                                          : teamIssue.nextFollowUpDate ??
                                              "No Date",
                                  issues: filteredIssues,
                                );
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

  List<IssueShort> filterIssues(
      List<IssueShort>? issues, String selectedBCDFilter) {
    switch (selectedBCDFilter) {
      case "Blocked":
        return issues?.where((issue) => issue.isBlocked == true).toList() ?? [];
      case "Critical":
        return issues?.where((issue) => issue.isCritical == true).toList() ??
            [];
      case "Delayed":
        return issues?.where((issue) => issue.delayed > 1).toList() ?? [];
      default:
        return issues ?? [];
    }
  }
}
