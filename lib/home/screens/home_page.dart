import 'package:bizissue/home/screens/business_home_page.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/home/screens/simple_home_page.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; // Import the GoRouter package

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
                    GoRouter.of(context).go('/login'); // Example: Navigate to login page
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
              ? BusinessHomePage(id : ref.selectedBusiness)
              : NoBusinessHomePage();
        },
      ),
    );
  }
}



/* SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(71),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomMenuButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                        // Move to the login screen
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
              children: const [

              ],
              onPageChanged: (page) {
                ref.onPageChanged(page);
              },
            );
          }),
        ),
        bottomNavigationBar:
        Consumer<HomeProvider>(builder: (context, ref, child) {
          return BottomNavigationBar(
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
                  color: ref.page == 0 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: ref.page == 1 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Issue",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: ref.page == 2 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Activity",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.groups_rounded,
                  color: ref.page == 3 ? kprimaryColor : kSecondaryColor,
                ),
                label: "Groups",
              ),
            ],
            onTap: (page) {
              ref.navigationTapped(page);
            },
          );
        }),
        drawer: userModel == null
            ? null
            : MyDrawer(
          name:
          "${(userModel.name)}",
        ),
      ),
    );*/