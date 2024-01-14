import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/empty_screen.dart';
import 'package:bizissue/business_home_page/widgets/issue_tile.dart';
import 'package:bizissue/business_home_page/widgets/toggle_switch.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';

class IssuePage extends StatefulWidget {
  final String issueId;
  final String businessId;

  const IssuePage({Key? key, required this.issueId, required this.businessId})
      : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  @override
  void initState() {
    super.initState();
    callInit();
  }

  void callInit() {
    Provider.of<IssueProvider>(context, listen: false)
        .sendIssueGetRequest(widget.businessId, widget.issueId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child:
          Consumer<IssueProvider>(builder: (context, issueController, child) {
        return issueController.issueModel == null
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
                Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.19),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x1E000000),
                                  blurRadius: 4,
                                  offset: Offset(-3, 3),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                issueController.clearData();
                                GoRouter.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            issueController.issueModel?.title ?? "Error",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Blocked :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(width: width * 0.03),
                              Switch(
                                  value: issueController
                                          ?.issueModel?.blocked?.isBlocked ??
                                      true ,
                              onChanged: (bool isSwitched){
                                    issueController.setFetching(true);
                                    if(issueController.issueModel!.blocked.isBlocked == false){
                                      issueController.bockIssueRequest(context, widget.businessId);
                                    }
                                    else{
                                      issueController.unbockIssueRequest(context, widget.businessId);
                                    }
                              },
                              ),
                              SizedBox(width: width * 0.08),
                              Text(
                                "Critical :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(width: width * 0.03),
                              Switch(
                                value: issueController?.issueModel?.critical?.isCritical ?? true,
                                onChanged: (bool isSwitched) {
                                  issueController.setFetching(true);
                                  if(issueController.issueModel!.critical.isCritical == false){
                                    issueController.markCriticalIssueRequest(context, widget.businessId);
                                  }
                                  else{
                                    issueController.unmarkCriticalIssueRequest(context, widget.businessId);
                                  }
                                },
                              ),

                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Next follow up date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                issueController.issueModel?.nextFollowUpDate ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              IconButton(
                                  onPressed: () async {

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
                                        issueController.setFetching(true);
                                        issueController.updateNextFollowUpDateRequest(context, widget.businessId, validDeliveryDate);
                                      });
                                    }

                                  }, icon: Icon(Icons.edit))
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                issueController.issueModel?.deliveryDate ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              IconButton(
                                  onPressed: () async {

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
                                        issueController.setFetching(true);
                                        issueController.updateDeliveryDateRequest(context, widget.businessId, validDeliveryDate);
                                      });
                                    }

                                  }, icon: Icon(Icons.edit))
                            ],
                          ),

                          SizedBox(height: height*0.01,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Delayed:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),

                              SizedBox(width: width*0.05,),

                              Text(
                                issueController.issueModel?.delayed.toString() ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                if (issueController
                    .isFetching) // Show circular progress indicator conditionally
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ]);
      }),
    );
  }
}
