import 'package:bizissue/business_home_page/widgets/reject_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/business_home_page/widgets/accpet_request_dialog.dart';
import 'package:bizissue/business_home_page/widgets/declined_request_tile.dart';
import 'package:bizissue/business_home_page/widgets/request_tile.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';

class BusinessRequestsPage extends StatefulWidget {
  final String businessId;

  // Constructor with a required parameter
  BusinessRequestsPage({required this.businessId});

  @override
  State<BusinessRequestsPage> createState() => _BusinessRequestsPageState();
}

class _BusinessRequestsPageState extends State<BusinessRequestsPage> {
  @override
  void initState() {
    super.initState();
    callInit();
  }

  Future<void> callInit() async {
    await Provider.of<BusinessRequestsProvider>(context, listen: false)
        .getRequestsList(context, widget.businessId);
    await Provider.of<BusinessRequestsProvider>(context, listen: false)
        .getDeclinedRequestsList(context, widget.businessId);
    setState(() {}); // Trigger a rebuild after data is fetched
  }

  @override
  Widget build(BuildContext context) {
    // final homeController = Provider.of<HomeProvider>(context, listen: false);
    final requestController =
        Provider.of<BusinessRequestsProvider>(context, listen: true);

    if (requestController.userRequestlist == null || requestController.declinedRequestUsersList == null)  {
      callInit();
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 20),
              Text(
                "Requests",
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
      body: (requestController.userRequestlist == null ||
              requestController.declinedRequestUsersList == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  requestController.clear();
                  setState(() {});
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: height*0.01,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text("Requests " , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w600),)),
                    SizedBox(
                      height: height*0.01,
                    ),
                    if (requestController.userRequestlist != null &&
                        requestController.userRequestlist!.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: requestController.userRequestlist!.length,
                        itemBuilder: (context, index) {
                          RequestUserModel user =
                              requestController.userRequestlist![index];
                          return RequestTile(
                            name: user.name,
                            contactNumber: user.contactNumber,
                            onAccept: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    UserSelectionDialog(userId: user.userId),
                              );
                            },
                            onReject: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DenyLeaveRequestDialog(
                                    userId: user.userId,
                                    name: user.name,
                                    contactNumber: user.contactNumber,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),

                    SizedBox(
                      height: height*0.02,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text("Declined Requests " , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w600),)),
                    SizedBox(
                      height: height*0.01,
                    ),

                    if (requestController.declinedRequestUsersList != null &&
                        requestController.declinedRequestUsersList!.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            requestController.declinedRequestUsersList!.length,
                        itemBuilder: (context, index) {
                          DeclinedRequestUser declinedRequestUser =
                              requestController
                                  .declinedRequestUsersList![index];
                          return DeclinedRequestTile(
                              declinedRequestUser: declinedRequestUser);
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
