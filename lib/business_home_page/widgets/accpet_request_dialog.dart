import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserSelectionDialog extends StatefulWidget {
  final String userId;

  UserSelectionDialog({required this.userId});

  @override
  _UserSelectionDialogState createState() => _UserSelectionDialogState();
}
class _UserSelectionDialogState extends State<UserSelectionDialog> {

  UserListModel? selectedUserListItem;

  List<String> roles = ["MiniAdmin", "User"];

  @override
  Widget build(BuildContext context) {

    final businessRequestController = Provider.of<BusinessRequestsProvider>(context, listen: false);
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    final createIssueController = Provider.of<CreateIssueProvider>(context, listen: false);


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Select Manager and Role",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Assign To",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.06,
              width: double.maxFinite-10,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FutureBuilder<List<UserListModel>>(
                future: homeController.getUsersList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Center(child: Text('Error loading data'));
                  } else {
                    List<UserListModel> userList = snapshot.data!;

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<UserListModel>(
                        icon: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        elevation: 4,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        value: selectedUserListItem,
                          onChanged: (UserListModel? newValue) {
                            if (newValue != null) {
                              selectedUserListItem = newValue;
                              print("Selected user : ${selectedUserListItem?.name ?? "No"}" );
                              businessRequestController.updateAssignTo(selectedUserListItem);
                              setState(() {});
                            }
                          },

                        items: userList.map<DropdownMenuItem<UserListModel>>(
                              (UserListModel user) {
                            return DropdownMenuItem<UserListModel>(
                              value: user,
                              child: Text("  ${user.name}"),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Select role",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.06,
              width: double.maxFinite-10,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: const Align(
                    alignment:
                    Alignment.centerRight,
                    child: Icon(
                      Icons
                          .keyboard_arrow_down_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 4,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14),
                  value: businessRequestController.userRoleModel?.role ?? null,
                  onChanged: (p0){
                    businessRequestController.updateRole(p0);
                    setState(() {

                    });
                  },
                  items: roles.map<
                      DropdownMenuItem<String>>(
                          (String s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text("  $s"),
                        );
                      }).toList(),
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop(); // Close the dialog
                  },
                  child: Text("Close"),
                ),
                ElevatedButton(
                  onPressed: () {
                    businessRequestController.setUserId(widget.userId);
                    businessRequestController.acceptRequestPost(context , homeController.selectedBusiness);
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
