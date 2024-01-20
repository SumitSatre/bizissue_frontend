
import 'package:bizissue/group/models/group_model.dart';
import 'package:flutter/material.dart';

class GroupSelectionWidget extends StatefulWidget {
  final List<GroupUsersIdModel> groupUsersIds;
  final List<String> selectedUsers;
  final Function(List<String>) onSelectionChanged;

  GroupSelectionWidget({
    required this.groupUsersIds,
    required this.selectedUsers,
    required this.onSelectionChanged,
  });

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
                                value: widget.selectedUsers.contains(group.groupId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value ?? false) {
                                      widget.selectedUsers.add(group.groupId);
                                      widget.selectedUsers.addAll(group.usersIds);
                                    } else {
                                      widget.selectedUsers.remove(group.groupId);
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
                                title: Text(userId),
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
                    widget.onSelectionChanged(widget.selectedUsers);
                    Navigator.of(context).pop();
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
                    : widget.selectedUsers.join(', '),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}
