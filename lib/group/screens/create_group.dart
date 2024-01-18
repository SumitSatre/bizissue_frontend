import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:bizissue/widgets/custom_text_field.dart';
import 'package:bizissue/widgets/custom_text_form_field.dart';
import 'package:bizissue/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  late List<String> _selectedOptions = [];

  // homeController.getUsersList(homeController!.selectedBusiness)
  void callInit(BuildContext context) async {
    try {
      await Provider.of<HomeProvider>(context, listen: false)
          .getUsersList()
          .then((_) {
        setState(() {});
      });
    } catch (error) {
      print('Error in callInit: $error');
      showSnackBar(context, "Unable to fetch users list!!", failureColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    if (homeController.userlistModel == null) {
      callInit(context);
    }
    final groupController = Provider.of<GroupProvider>(context, listen: false);

   // final createIssueController =
   //     Provider.of<CreateIssueProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _selectedOptions = groupController.createGroupResponseModel?.usersToAddIds ?? [];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * .19),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.02, horizontal: width * .04),
            child: Row(
              children: [
                CustomBackButton(),
                SizedBox(width: 20),
                Text(
                  "Create Group",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              CustomTextField(
                controller: groupController.nameController,
                onChanged: (p0) => groupController.updateGroupName(p0 ?? ""),
                labelText: "Name*",
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Select Users To Add: ",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: height * 0.02),

              homeController.userlistModel == null
                  ? Container(
                      height: 35,
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Select Options'),
                                  content: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return SizedBox(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          itemCount: homeController
                                                  .userlistModelWihoutMySelf
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            UserListModel userModel = homeController
                                                    .userlistModelWihoutMySelf![
                                                index];
                                            return CheckboxListTile(
                                              title: Text(userModel.name),
                                              value: _selectedOptions
                                                  .contains(userModel.userId),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (value ?? false) {
                                                    _selectedOptions
                                                        .add(userModel.userId);
                                                  } else {
                                                    _selectedOptions.remove(
                                                        userModel.userId);
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
                                        // Replace 'controller' with the correct controller instance
                                        groupController.updateSelectedUsers(
                                            _selectedOptions);
                                        Navigator.of(context).pop();
                                        setState(() {

                                        });
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.9,
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
                                    _selectedOptions.isEmpty
                                        ? "Choose Users"
                                        : _selectedOptions
                                            .map((userId) => homeController
                                                .userlistModelWihoutMySelf!
                                                .firstWhere((user) =>
                                                    user.userId == userId)
                                                .name)
                                            .join(', '),
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: height * 0.02),
              SubmitButton(
                onPressed: () {
                  groupController.createGroupRequest(context , homeController.selectedBusiness);
                },
              ), // Add a closing parenthesis here
            ],
          ),
        ),
      ),
    );
  }
}

/* onRefresh: () async {
            print("Done");
            try {
               homeController.setUserListNull();
               groupController.setCreateGroupVariablesNull();
               callInit(context);
            } catch (error) {
              print('Error during refresh: $error');
            }
          }, */