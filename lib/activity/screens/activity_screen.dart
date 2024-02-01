import 'package:bizissue/activity/widgets/activity_tile.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/controller/view_group_controller.dart';
import 'package:bizissue/group/widgets/group_tile.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart'; // Import your GroupShortModel class
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/utils/utils.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final businessController =
        Provider.of<BusinessController>(context, listen: false);

    return Scaffold(
      body: businessController.businessModel == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount:
                  businessController?.businessModel?.user?.activities.length ??
                      0,
              itemBuilder: (context, index) {
                ActivityModel activity =
                    businessController!.businessModel!.user!.activities![index];

                return ActivityTile(activity: activity);
              }),
    );
  }
}
