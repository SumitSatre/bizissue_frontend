import 'package:bizissue/activity/screens/activity_screen.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/business%20home/create_issue_page.dart';
import 'package:bizissue/business_home_page/widgets/empty_screen.dart';
import 'package:bizissue/business_home_page/widgets/view_issues_page.dart';
import 'package:bizissue/group/screens/group_page.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/outsider/controllers/outsider_controller.dart';
import 'package:bizissue/outsider/widgets/appbar_outsider.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';

class OutsiderPage extends StatefulWidget {
  const OutsiderPage({Key? key}) : super(key: key);

  @override
  State<OutsiderPage> createState() => OutsiderPageState();
}

class OutsiderPageState extends State<OutsiderPage> {
  @override
  void initState() {
    super.initState();
    callInit();
  }

  void callInit() {
    String selectedBusiness =
        Provider.of<HomeProvider>(context, listen: false).selectedBusiness;
    print("Fetched on business page!!");
    Provider.of<OutsiderProvider>(context, listen: false)
        .sendUserGetRequest(selectedBusiness);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Provider.of<HomeProvider>(context, listen: false);

    final outsiderController =
        Provider.of<OutsiderProvider>(context, listen: true);

    return SafeArea(
        child: Scaffold(
      appBar: MyAppBarOutsider(),
      body: outsiderController.myIssuesGroup == null
          ? CircularProgressIndicator()
          : ViewIssuesWidget(
              key: UniqueKey(),
              groupIssues: outsiderController.myIssuesGroup!,
            ),
      drawer: userModel == null
          ? null
          : MyDrawer(
              name: "${(userModel.name)}",
            ),
    ));
  }
}
