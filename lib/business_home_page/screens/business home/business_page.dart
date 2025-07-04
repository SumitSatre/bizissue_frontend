import 'package:bizissue/activity/screens/activity_screen.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/business%20home/create_issue_page.dart';
import 'package:bizissue/business_home_page/widgets/empty_screen.dart';
import 'package:bizissue/group/screens/group_page.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';
import 'business_home_page.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    callInit();

    final controller = Provider.of<HomeProvider>(context, listen: false);

    final username =
        "${controller.userModel?.id ?? ""}_${controller.selectedBusiness}";

    socket = IO.io(
        'https://bizissue-backend.onrender.com/business/activity',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

    socket.connect();

    socket.onConnect((_) {
      print('connected in home');

      socket.emit("business-user-joined", username);
    });

    socket.on('business-new-activity', (data) {
      print("This data is received : ${data}");
      final newActivity = ActivityModel(
        activityCategory: data['activityCategory'],
        content: data['content'],
        issueId: data['issueId'] ?? "",
        issueTitle: data['issueTitle'] ?? "",
        createdDate: DateTime.fromMillisecondsSinceEpoch(data['createdDate']),
        groupId: data['groupId'] ?? "",
        groupName: data['groupName'] ?? "",
      );

      final businessController =
          Provider.of<BusinessController>(context, listen: false);

      if (businessController.businessModel != null) {
        businessController.businessModel!.user.activities
            .insert(0, newActivity);
        businessController.notifyListeners();
      }
    });
  }

  void callInit() {
    String selectedBusiness =
        Provider.of<HomeProvider>(context, listen: false).selectedBusiness;
    print("Fetched on business page!!");
    Provider.of<BusinessController>(context, listen: false)
        .init(selectedBusiness);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Provider.of<HomeProvider>(context, listen: false);

    // final ref = Provider.of<BusinessController>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: Consumer<BusinessController>(builder: (context, ref, child) {
            return ref.isError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Something got wrong please try again!!"),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .updateisError();
                              SharedPreferenceService().clearLogin();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MyAppRouteConstants.loginRouteName,
                                  (route) => false);
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
        bottomNavigationBar:
            Consumer<BusinessController>(builder: (context, ref, child) {
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
            selectedLabelStyle: TextStyle(
                fontFamily: "Poppins",
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6E24E9)),
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
                icon: Stack(
                  children: <Widget>[
                    Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color:
                              ref.businessModel?.user?.activityViewCounter != 0
                                  ? Colors.red
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          ref.businessModel?.user?.activityViewCounter
                                  .toString() ??
                              "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
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
                name: "${(userModel.name)}",
              ),
      ),
    );
  }
}
