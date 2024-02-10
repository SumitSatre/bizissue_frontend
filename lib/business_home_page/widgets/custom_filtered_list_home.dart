import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/custom_expannsion_tile.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class CustomFilteredListHome extends StatefulWidget {
  @override
  State<CustomFilteredListHome> createState() => _CustomFilteredListHomeState();
}

class _CustomFilteredListHomeState extends State<CustomFilteredListHome> {
  bool _switchValue = false;
  bool isSwitched = true;
  String? selectedBCDFilter = "All"; // Set your default value here

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final todaysDate = DateTime.now()
        .toString(); // You can replace this with your actual logic
    final tomorrowsDate = DateTime.now().add(Duration(days: 1)).toString();

    final businessController =
        Provider.of<BusinessController>(context, listen: true);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(width: width * 0.02),
              SizedBox(
                width: width * 0.443,
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ToggleSwitch(
                        initialLabelIndex: isSwitched ? 0 : 1,
                        inactiveBgColor: kbackgroundColor,
                        activeBgColor: [kprimaryColor],
                        fontSize: 13,
                        multiLineText: true,
                        minWidth: width * 0.22,
                        totalSwitches: 2,
                        labels: ['My Issues', 'My Team Issues'],
                        centerText: true,
                        onToggle: (index) {
                          setState(() {
                            isSwitched = index == 0;
                          });
                        },
                      ),
                    ),
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
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    value: selectedBCDFilter,
                    onChanged: (p0) {
                      if (p0 != null) {
                        setState(() {
                          selectedBCDFilter = p0;
                        });
                      }
                    },
                    items: BCDList.map<DropdownMenuItem<String>>((String s) {
                      return DropdownMenuItem<String>(
                        value: s,
                        child: Text("  $s"),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              Container(
                width: width * 0.22,
                height: 36,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _switchValue = false;
                          businessController.sortAccordingToNextFollowUpDate();
                          businessController.notifyListeners();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: _switchValue ? Colors.grey : Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'NFD',
                            style: TextStyle(
                              color: _switchValue ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _switchValue = true;
                          businessController.sortAccordingToDeliveryDate();
                          businessController.notifyListeners();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: _switchValue ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'DD',
                            style: TextStyle(
                              color: _switchValue ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Expanded(
          child: ListView.builder(
            itemCount: isSwitched
                ? businessController.myIssuesGroup?.length ?? 0
                : businessController.myTeamIssuesGroup?.length ?? 0,
            itemBuilder: (context, index) {
              GroupIssue groupIssue = isSwitched
                  ? businessController.myIssuesGroup![index]
                  : businessController.myTeamIssuesGroup![index];

              if (groupIssue == null ||
                  groupIssue.issues == null ||
                  groupIssue.issues!.length < 1) {
                return Center(child: Text("No Data"));
              } else {
                List<IssueModel> filteredIssues =
                    filterIssues(groupIssue.issues, selectedBCDFilter!);

                if (filteredIssues.isEmpty) {
                  return Container();
                }

                return CustomExpansionTile(
                  title: groupIssue.date == todaysDate
                      ? "Today"
                      : groupIssue.date == tomorrowsDate
                          ? "Tomorrow"
                          : groupIssue.date ?? "No Date",
                  issues: filteredIssues,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
