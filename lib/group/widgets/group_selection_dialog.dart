import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/group/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupSelectionWidget extends StatefulWidget {
  final List<GroupUsersIdModel> groupUsersIds;
  final List<String> selectedUsers;
  final List<UserListModel>? userlistModel; // Added userlistModel

  GroupSelectionWidget({
    required this.groupUsersIds,
    required this.selectedUsers,
    required this.onSelectionChanged,
    this.userlistModel, // Added userlistModel to the constructor
  });

  final Function(List<String>) onSelectionChanged;

  @override
  _GroupSelectionWidgetState createState() => _GroupSelectionWidgetState();
}

class _GroupSelectionWidgetState extends State<GroupSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select Groups'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: widget.groupUsersIds.length,
                      itemBuilder: (context, index) {
                        GroupUsersIdModel group = widget.groupUsersIds[index];
                        return ExpansionTile(
                          title: Row(
                            children: [
                              Text(group.name),
                              Checkbox(
                                value: areAllGroupMembersSelected(group , widget.selectedUsers),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value ?? false) {
                                      widget.selectedUsers.addAll(group.usersIds);
                                    } else {
                                      widget.selectedUsers.removeWhere((userId) =>
                                          group.usersIds.contains(userId));
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          children: [
                            for (String userId in group.usersIds)
                              CheckboxListTile(
                                title: Text(getUserName(userId)),
                                value: widget.selectedUsers.contains(userId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value ?? false) {
                                      widget.selectedUsers.add(userId);
                                    } else {
                                      widget.selectedUsers.remove(userId);
                                    }
                                  });
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Remove all group IDs from the selectedUsers list
                    widget.selectedUsers.removeWhere((userId) =>
                        widget.groupUsersIds.any((group) => group.groupId == userId));

                    widget.onSelectionChanged(removeDuplicates(widget.selectedUsers));
                    GoRouter.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.selectedUsers.isEmpty
                    ? "Choose Users"
                    : widget.selectedUsers.map((userId) => getUserName(userId)).join(', '),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }

  // Helper method to get user name based on user ID
  String getUserName(String userId) {
    // print("Hi");
    if (widget.userlistModel != null) {
      var user = widget.userlistModel!.firstWhere((user) => user.userId == userId, orElse: () => UserListModel(userId: userId, name: "Unknown"));
      return user.name;
    } else {
      return userId; // Return user ID if userlistModel is not provided
    }
  }

  bool areAllGroupMembersSelected(GroupUsersIdModel groupUsersIds, List<String> selectedUsers) {
    // Flatten the list of usersIds from all groups
    List<String> allGroupMembers = groupUsersIds.usersIds ?? [];
    // Check if all group members are present in the selectedUsers list
    return allGroupMembers.every((userId) => selectedUsers.contains(userId));
  }

  List<String> removeDuplicates(List<String> inputList) {
    // Using a Set to efficiently remove duplicates
    Set<String> uniqueSet = Set<String>.from(inputList);

    // Converting the Set back to a List
    List<String> result = uniqueSet.toList();

    return result;
  }


}