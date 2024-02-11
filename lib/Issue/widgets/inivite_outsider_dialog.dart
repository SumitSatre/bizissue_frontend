import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:bizissue/auth/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class InviteOutsiderDialog extends StatefulWidget {
  final String issueId;
  final BuildContext prevContext;

  InviteOutsiderDialog({required this.prevContext,required this.issueId});

  @override
  _InviteOutsiderDialogState createState() => _InviteOutsiderDialogState();
}

class _InviteOutsiderDialogState extends State<InviteOutsiderDialog> {
  final TextEditingController countryCodeController =
      TextEditingController(text: "+91");
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final businessRequestController =
        Provider.of<BusinessRequestsProvider>(context, listen: false);
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    final issueController =
        Provider.of<IssueProvider>(context, listen: false);

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
              "Enter contact number to invite",
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
                  "Contact Number",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.007),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5),
                    Container(
                      height: 50,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12)),
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
                          value: countryCodeController.text,
                          onChanged: (code) {
                            setState(() {
                              countryCodeController.text = code ?? '+91';
                            });
                          },
                          items: countryCodesList
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
                SizedBox(
                  width: width * 0.01,
                ),
                SizedBox(
                  width: width * 0.50,
                  height: 50,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          10), // Limits input to 10 characters
                      FilteringTextInputFormatter
                          .digitsOnly, // Allows only digits
                    ],
                    initialValue: '',
                    onChanged: (value) {
                      numberController.text = value ?? "";
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: "Enter Contact Number",
                      hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.shade600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
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
                    GoRouter.of(context).pop();
                    issueController.sentInviteToOutsiderRequest(widget.prevContext , countryCodeController.text , numberController.text);
                    GoRouter.of(context).pop();
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
