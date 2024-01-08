import 'package:bizissue/business_home_page/screens/activity_page.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/create_issue_page.dart';
import 'package:bizissue/business_home_page/screens/group_page.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';
import 'business_home_page.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller =
    Provider.of<HomeProvider>(context, listen: false);

    final ref =
    Provider.of<BusinessController>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: Consumer<HomeProvider>(builder: (context, ref, child) {
            return ref.isError
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Your token has expired.please login again"),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .updateisError();
                        SharedPreferenceService().clearLogin();
                        Navigator.pushNamedAndRemoveUntil(context,
                            MyAppRouteConstants.loginRouteName, (route) => false);
                      },
                      child: const Text("Login  again"))
                ],
              ),
            )
                : userModel == null
                ? const Center(
              child: CircularProgressIndicator(
                color: kprimaryColor,
              ),
            )
                : PageView(
              controller: ref.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BusinessHomePage(id: controller.selectedBusiness),
                CreateIssuePage(),
                ActivityPage(),
                GroupPage()
              ],
              onPageChanged: (page) {
                ref.onPageChanged(page);
              },
            );
          }),
        ),

        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: kbackgroundColor,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: ref.page,
            selectedItemColor: kprimaryColor,
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500),
            selectedLabelStyle: const TextStyle(
                fontFamily: "Poppins",
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
                color: kprimaryColor),
            iconSize: 28,
            elevation: 100,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                  color: controller.page == 0 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: controller.page == 1 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Issue",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: controller.page == 2 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Activity",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.groups_rounded,
                  color: controller.page == 3 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Groups",
              ),
            ],
            onTap: (page) {
              controller.navigationTapped(page);
            },
          ),

        drawer: userModel == null
            ? null
            : MyDrawer(
          name:
          "${(userModel.name)}",
        ),

      ),
    );
  }
}
