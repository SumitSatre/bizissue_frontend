import 'package:bizissue/business_home_page/widgets/no_business_app_bar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';

class NoBusinessHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      appBar: NoBusinessAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                GoRouter.of(context).pushNamed(MyAppRouteConstants.createBusinessRouteName);
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Create Business',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                GoRouter.of(context).pushNamed(MyAppRouteConstants.joinBusinessRouteName);
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Join Business',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: userModel == null
          ? null
          : MyDrawer(
        name: "${userModel.name}",
      ),
    );
  }
}
