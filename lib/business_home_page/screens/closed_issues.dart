import 'package:bizissue/business_home_page/screens/controller/business_users_controller.dart';
import 'package:bizissue/business_home_page/widgets/custom_filtered_list_closed_issues.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClosedIssues extends StatefulWidget {
  @override
  State<ClosedIssues> createState() => _ClosedIssuesState();
}

class _ClosedIssuesState extends State<ClosedIssues> {
  @override
  void initState() {
    super.initState();
    callInit();
    setState(() {});
  }

  Future<void> callInit() async {
    final businessId =
        Provider.of<HomeProvider>(context, listen: false).selectedBusiness;

    await Provider.of<BusinessUsersProvider>(context, listen: false)
        .getClosedIssueRequest(businessId);
  }

  @override
  Widget build(BuildContext context) {
    final businessUsersController =
        Provider.of<BusinessUsersProvider>(context, listen: true);
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
                  "Closed Issues",
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
        body: businessUsersController.myIssues == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomFilteredListClosedIssues());
  }
}
