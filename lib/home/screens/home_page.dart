import 'package:bizissue/business_home_page/screens/business%20home/business_home_page.dart';
import 'package:bizissue/business_home_page/screens/business%20home/business_page.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/home/screens/simple_home_page.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/app_route_constants.dart';
import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "home-screen";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    callInit();
  }

  void callInit() {
    Provider.of<HomeProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Consumer<HomeProvider>(
        builder: (context, ref, child) {
          return ref.isError
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Your token has expired. Please login again"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateisError();
                    SharedPreferenceService().clearLogin();
                    // Move to the login screen
                    Navigator.of(context).pushNamed(MyAppRouteConstants.loginRouteName);
                  },
                  child: const Text("Login again"),
                ),
              ],
            ),
          )
              : userModel == null
              ? const Center(
            child: CircularProgressIndicator(
              color: kprimaryColor,
            ),
          )
              : ref.selectedBusiness != ""
              ? BusinessPage()
              : NoBusinessHomePage();
        },
      ),
    );
  }
}