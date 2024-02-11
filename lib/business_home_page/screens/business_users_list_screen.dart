import 'package:bizissue/activity/widgets/activity_tile.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/user_record_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/business_users_controller.dart';
import 'package:bizissue/business_home_page/widgets/usser_record_tile.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/group/widgets/group_tile.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart'; // Import your GroupShortModel class
import 'package:bizissue/home/models/user_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/utils/utils.dart';

class BusinessUsersListScreen extends StatefulWidget {
  final String businessId;

  // Constructor with a required parameter
  BusinessUsersListScreen({required this.businessId});

  @override
  _BusinessUsersListScreenState createState() =>
      _BusinessUsersListScreenState();
}

class _BusinessUsersListScreenState extends State<BusinessUsersListScreen> {
  @override
  void initState() {
    super.initState();
    callInit();
    setState(() {});
  }

  Future<void> callInit() async {
    await Provider.of<BusinessUsersProvider>(context, listen: false)
        .getUsersInBusiness(context, widget.businessId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final businessUsersController =
        Provider.of<BusinessUsersProvider>(context, listen: true);
    //final businessController =
    //    Provider.of<BusinessController>(context, listen: false);

    return Consumer<BusinessController>(
        builder: (context, businessController, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Row(
              children: [
                CustomBackButton(),
                SizedBox(width: 20),
                Text(
                  "Users",
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
        body: businessUsersController.usersList == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: businessUsersController?.usersList?.length ?? 0,
                itemBuilder: (context, index) {
                  UserRecord user = businessUsersController!.usersList![index];

                  return UserRecordTile(
                    userRecord: user,
                      prevContext: context
                  );
                }),
      );
    });
  }
}
