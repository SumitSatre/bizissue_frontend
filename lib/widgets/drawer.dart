// ignore_for_file: prefer_const_constructors

import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/screens/business_home_page.dart';

class MyDrawer extends StatefulWidget {
  final String name;

  const MyDrawer({Key? key, required this.name})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // final imageURL =
  //     "https://e0.pxfuel.com/wallpapers/900/942/desktop-wallpaper-cartoon-cartoon-new-cartoon-boy-cartoon-letest-cartoon-cute-cartoon-cute-bay-cartoon-kartoon-thumbnail.jpg";

  @override
  Widget build(BuildContext context) {
    final userModel =
        Provider.of<HomeProvider>(context, listen: true).userModel;
    final controller = Provider.of<HomeProvider>(context, listen: false);
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              color: Colors.black,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.zero,
                  accountName: Text(widget.name , style: TextStyle(fontSize: 20),),
                  accountEmail: null, // Set accountEmail to null
                  currentAccountPicture: CircleAvatar(
                   // backgroundImage:
                   // NetworkImage(),
                  ),
                ),
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
              contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 15),
            ),

            Column(
              children: userModel!.businesses!.map((business) {
                return ListTile(
                  onTap: () {
                    controller.selectedBusiness = business.businessId;

                    controller.updateSelected(context , userModel.businesses[0].businessId);

                  },
                  //leading: Icon(
                  //  Icons.person_2_outlined,
                  //  color: Colors.white,
                  //),
                  title: Text(
                    business.name,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 20),
                  // dense: true,
                );
              }).toList(),
            ),

            Divider(color: Colors.grey),

            ListTile(
              leading: Icon(
                Icons.person_2_outlined,
                color: Colors.white,
              ),
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
              leading: Icon(
                CupertinoIcons.doc,
                color: Colors.white,
              ),
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
              leading: Icon(
                CupertinoIcons.question_circle_fill,
                color: Colors.white,
              ),
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
              onTap: () {
              },
              leading: Icon(
                CupertinoIcons.settings_solid,
                color: Colors.white,
              ),
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
              onTap: () {
                // SharedPreferenceService().clearLogin();
              },
              leading: Icon(
                CupertinoIcons.power,
                color: Colors.white,
              ),
              title: Text(
                "Log Out",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
