import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserSelectionGroupDialog extends StatefulWidget {
  final List<UserListModel> userList;
  final List<String> selectedOptions;
  final Function(List<String>) onSelectionChanged;

  UserSelectionGroupDialog({
    required this.userList,
    required this.selectedOptions,
    required this.onSelectionChanged,
  });

  @override
  _UserSelectionGroupDialogState createState() => _UserSelectionGroupDialogState();
}

class _UserSelectionGroupDialogState extends State<UserSelectionGroupDialog> {
  @override
  Widget build(BuildContext context) {
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
            GoRouter.of(context).pop();
            widget.onSelectionChanged(widget.selectedOptions);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Cleanup code, if needed
    super.dispose();
  }

}
