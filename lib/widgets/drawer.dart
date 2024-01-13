import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  final String name;

  const MyDrawer({Key? key, required this.name}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final userModel =
        Provider.of<HomeProvider>(context, listen: true).userModel;
    final controller = Provider.of<HomeProvider>(context, listen: false);
    final businessController =
    Provider.of<BusinessController>(context, listen: false);
    final IssueController = Provider.of<CreateIssueProvider>(context, listen: false);
    final businessRequestController = Provider.of<BusinessRequestsProvider>(context, listen: false);

    return Drawer(
      child: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                margin: EdgeInsets.zero,
                accountName: Text(widget.name, style: TextStyle(fontSize: 20)),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  minRadius: 125,
                  maxRadius: 130,
                  backgroundImage: AssetImage("assets/images/person.png"),
                ),
              ),

              Divider(color: Colors.grey),
              ListTile(
                title: Text(
                  "Businesses",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Your logic for handling business selection
                },
              ),

              Divider(color: Colors.grey),
              ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: userModel!.businesses!.map((business) {
                  return ListTile(
                    title: Text(
                      business.name,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      GoRouter.of(context).pop();
                      businessController.setBusinessModelNull();
                      controller.setNewBusiness(context, business.businessId);
                    },
                  );
                }).toList(),
              ),

              Divider(color: Colors.grey),

              ListTile(
                trailing: Icon(CupertinoIcons.add, color: Colors.white),
                title: Text(
                  "Create Business",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onTap: (){
                  GoRouter.of(context).pop();   // pop the drawer
                  GoRouter.of(context).pushNamed(MyAppRouteConstants.createBusinessRouteName);
                },
              ),

              ListTile(
                // trailing: Icon(CupertinoIcons., color: Colors.white),
                title: Text(
                  "Join Business",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: (){
                  GoRouter.of(context).pop();   // pop the drawer
                  GoRouter.of(context).pushNamed(MyAppRouteConstants.joinBusinessRouteName);
                },
              ),

              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.person_2_outlined, color: Colors.white),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.doc, color: Colors.white),
                title: Text(
                  "Contact us",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.question_circle_fill, color: Colors.white),
                title: Text(
                  "Help",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.settings_solid, color: Colors.white),
                title: Text(
                  "Setting",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.power, color: Colors.white),
                title: Text(
                  "Log Out",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: (){
                  SharedPreferenceService().clearLogin();
                //  IssueController.clear();
                //  businessRequestController.clear();
                //  businessController.clear();
                //  controller.dispose();
                  GoRouter.of(context).goNamed(MyAppRouteConstants.loginRouteName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
