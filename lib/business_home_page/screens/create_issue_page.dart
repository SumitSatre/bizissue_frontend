import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CreateIssuePage extends StatefulWidget {
  @override
  _CreateIssuePageState createState() => _CreateIssuePageState();
}

class _CreateIssuePageState extends State<CreateIssuePage> {
  @override
  Widget build(BuildContext context) {

    final businessModel =
        Provider.of<BusinessController>(context).businessModel;

    if(businessModel == null){
      // traverse him to business home page
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final controller =
    // Provider.of<BusinessController>(context, listen: false);

    final createIssueController =
    Provider.of<CreateIssueProvider>(context, listen: false);

    return Scaffold(
      body: Column(
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: CustomTextFormField(
              isReadOnly: true,
              hintText: null,
              // initialValue: userModel.personalInfo.lastName,
              // onChanged: (p0) => controller.updateLastName(p0),
            ),
          ),

          SizedBox(height: height*0.02),

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

 //         Row(
 //           children: [
 //             SizedBox(width: 5),
 //             Container(
 //               height: height * 0.06,
 //               width: width - 41,
 //               decoration: BoxDecoration(
 //                   border: Border.all(
 //                     style: BorderStyle.solid,
 //                     color: Colors.grey,
 //                   ),
 //                   borderRadius: BorderRadius.circular(12)),
 //               child: DropdownButtonHideUnderline(
 //                 child: DropdownButton<String>(
 //                   icon: const Align(
 //                     alignment: Alignment.centerRight,
 //                     child: Icon(
 //                       Icons.keyboard_arrow_down_sharp,
 //                       color: Colors.grey,
 //                     ),
 //                   ),
 //                   elevation: 4,
 //                   style: const TextStyle(
 //                       color: Colors.black, fontSize: 14),
 //                  // value: ,
 //                  // onChanged: (p0) => controller
 //                  //     .updateAvgDurationOfPerfInternational(p0),
 //                   items:

 //                       .map<DropdownMenuItem<String>>(
 //                           (String s) {
 //                         return DropdownMenuItem<String>(
 //                           value: s,
 //                           child: Text("  $s"),
 //                         );
 //                       }).toList(),
 //                 ),
 //               ),
 //             ),
 //           ],
 //         ),

          SizedBox(height: height*0.02),


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

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true, // Make the text field read-only
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
          ),


          SizedBox(height: height*0.02),

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

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true, // Make the text field read-only
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
          ),

          SizedBox(height: height*0.02),



        ],
      ),
    );
  }
}
