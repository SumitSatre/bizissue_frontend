import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/home/models/user_model.dart';

class UserProfilePage extends StatefulWidget {
  String userId;
  String businessId;

  UserProfilePage({required this.userId, required this.businessId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    Provider.of<BusinessController>(context, listen: false).setUserProfileNull();
    Provider.of<BusinessController>(context, listen: false)
        .sendUserProfileGetRequest(widget.businessId, widget.userId)
        .then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile =
        Provider.of<BusinessController>(context, listen: true).userProfile;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 20),
              Text(
                "User Profile",
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
      body: userProfile == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/person.png'),
                radius: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${userProfile.user.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'User Type: ${userProfile.user.userType}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Role: ${userProfile.user.role}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Total Issues Count: ${userProfile.count.totalIssuesCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Delayed Count: ${userProfile.count.delayedCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Blocked Count: ${userProfile.count.blockedCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Critical Count: ${userProfile.count.criticalCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Expired Delivery Date Count: ${userProfile.count.expiredDeliveryDateCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Expired Next Follow-Up Date Count: ${userProfile.count.expiredNextFollowUpDateCount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle rate user action
              },
              child: Text('Rate User'),
            ),
          ],
        ),
      ),
    );
  }
}
