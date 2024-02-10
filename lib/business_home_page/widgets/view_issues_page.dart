import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/widgets/custom_expannsion_tile.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ViewIssuesWidget extends StatefulWidget {
  final List<GroupIssue> groupIssues;

  ViewIssuesWidget({Key? key, required this.groupIssues}) : super(key: key);

  @override
  _ViewIssuesWidgetState createState() => _ViewIssuesWidgetState();
}

class _ViewIssuesWidgetState extends State<ViewIssuesWidget> {
  String selectedBCDFilter = "All";
  String todaysDate = getFormattedDate(DateTime.now());
  String tomorrowsDate = getFormattedDate(DateTime.now().add(Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Filters:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Container(
                height: 36,
                width: 120,
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
                      setState(() {
                        if (p0 != null) {
                          selectedBCDFilter = p0;
                        }
                      });
                    },
                    items: BCDList
                        .map<DropdownMenuItem<String>>((String s) {
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
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: widget.groupIssues.length,
            itemBuilder: (context, index) {
              GroupIssue groupIssue = widget.groupIssues[index];

              if (groupIssue == null ||
                  groupIssue.issues == null ||
                  groupIssue.issues!.length < 1) {
                return Center(child: Text("No Data"));
              } else {
                List<IssueModel> filteredIssues = filterIssues(
                    groupIssue.issues, selectedBCDFilter);

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
