import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:flutter/material.dart';

class UserSelectionWidget extends StatefulWidget {
  final List<UserListModel> userList;
  final List<String> selectedOptions;
  final Function(List<String>) onSelectionChanged;

  UserSelectionWidget({
    required this.userList,
    required this.selectedOptions,
    required this.onSelectionChanged,
  });

  @override
  _UserSelectionWidgetState createState() => _UserSelectionWidgetState();
}

class _UserSelectionWidgetState extends State<UserSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select Options'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: widget.userList.length,
                      itemBuilder: (context, index) {
                        UserListModel userModel = widget.userList[index];
                        return CheckboxListTile(
                          title: Text(userModel.name),
                          value: widget.selectedOptions.contains(userModel.userId),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value ?? false) {
                                widget.selectedOptions.add(userModel.userId);
                              } else {
                                widget.selectedOptions.remove(userModel.userId);
                              }
                            });
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    widget.onSelectionChanged(widget.selectedOptions);
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
                widget.selectedOptions.isEmpty
                    ? "Choose Users"
                    : widget.selectedOptions
                    .map((userId) =>
                widget.userList.firstWhere(
                      (user) => user.userId == userId,
                  orElse: () => UserListModel(userId: userId, name: "Unknown"),
                )
                    .name)
                    .join(', '),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      ),
    );
  }
}
