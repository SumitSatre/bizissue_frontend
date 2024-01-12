import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CreateIssuePage extends StatefulWidget {
  @override
  _CreateIssuePageState createState() => _CreateIssuePageState();
}

class _CreateIssuePageState extends State<CreateIssuePage> {
  UserListModel? selectedUserListItem;

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    // if(businessModel == null){
    //   // traverse him to business home page
    // }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final controller =
    // Provider.of<BusinessController>(context, listen: false);

    final createIssueController =
        Provider.of<CreateIssueProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    "Issue",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              TextField(
                controller: TextEditingController(
                  text: createIssueController.createIssueModel?.title ?? "",
                ),
                onChanged: (p0) =>
                    createIssueController.updateIssueTitle(p0 ?? ""),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                cursorColor: Colors.black,
                cursorHeight: 22,
                cursorWidth: 1.8,
              ),
              SizedBox(height: height * 0.02),
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
                width: width - 41,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FutureBuilder<List<UserListModel>>(
                  future: createIssueController.getUsersList(homeController!.selectedBusiness),
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
                              // Update selectedUserListItem
                              selectedUserListItem = newValue;

                              // Update the controller property
                              createIssueController.updateAssignTo(selectedUserListItem);

                              // Trigger a rebuild of the widget
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

              SizedBox(height: height * 0.02),
              const Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    "Delivery Date",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: createIssueController.createIssueModel?.deliveryDate ?? ""),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(14),
                        filled: false,
                        suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (selectedDate != null) {
                              setState(() {
                                // Extract day, month, and year from the selected date
                                int day = selectedDate.day;
                                int month = selectedDate.month;
                                int year = selectedDate.year;

                                // Now you can use day, month, and year as needed
                                print("$year-$month-$day");
                                String deliveryDate = "$year-$month-$day";
                                String validDeliveryDate = convertDateFormat(deliveryDate);
                                createIssueController.updateDeliveryDateOfIssue(
                                    context, validDeliveryDate);
                              });
                            }
                          },
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      cursorColor: Colors.black,
                      cursorHeight: 22,
                      cursorWidth: 1.8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              const Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    "Next follow up date",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: createIssueController.createIssueModel?.nextFollowUpDate ?? ""),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(14),
                        filled: false,
                        suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (selectedDate != null) {
                              setState(() {
                                // Extract day, month, and year from the selected date
                                int day = selectedDate.day;
                                int month = selectedDate.month;
                                int year = selectedDate.year;

                                // Now you can use day, month, and year as needed

                                String nextFollowUpDate = "$year-$month-$day";

                                String validNextFollowUpDate = convertDateFormat(nextFollowUpDate);

                                print("Date : $validNextFollowUpDate");
                                createIssueController
                                    .updateNextFollowUpDateOfIssue(
                                        context, validNextFollowUpDate);
                              });
                            }
                          },
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      cursorColor: Colors.black,
                      cursorHeight: 22,
                      cursorWidth: 1.8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),

              Center(
                child: SizedBox(
                  height: 45,
                  width: 240,
                  child: ElevatedButton(
                    onPressed: () {
                      createIssueController.postIssue(context, homeController.selectedBusiness);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          submitButtonsColor),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
