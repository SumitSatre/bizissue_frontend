import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/rate_user_dialog.dart';
import 'package:bizissue/business_home_page/widgets/rating_list_item_tile.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:bizissue/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/home/models/user_model.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;
  final String businessId;

  UserProfilePage({required this.userId, required this.businessId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    Provider.of<BusinessController>(context, listen: false)
        .setUserProfileNull();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
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
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                      AssetImage('assets/images/person.png'),
                      radius: 35,
                    ),
                    Text(
                      userProfile?.user?.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10), // Border radius
                  color: Colors.white, // Background color
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKeyValuePair(
                      "Rating:",
                      (userProfile?.user?.totalRating ?? "").toString() + " ⭐",
                    ),
                    _buildKeyValuePair(
                      "Contact Number:",
                      userProfile.user.contactNumber.countryCode+" " + userProfile.user.contactNumber.number,
                    ),
                    _buildKeyValuePair(
                      "User Type:",
                      userProfile.user.userType,
                    ),
                    _buildKeyValuePair(
                      "Role:",
                      userProfile.user.role,
                    ),
                    _buildKeyValuePair(
                      "Last Seen:",
                      userProfile?.user?.lastSeen.toString() != null
                          ? convertUTCtoLocal(userProfile!.user!.lastSeen.toString())
                          : "",
                    ),
                    _buildKeyValuePair(
                      "Total Issues Count:",
                      userProfile.count.totalIssuesCount.toString() ?? "",
                    ),
                    _buildKeyValuePair(
                      "Delayed Count:",
                      userProfile.count.delayedCount.toString() ?? "",
                    ),
                    _buildKeyValuePair(
                      "Blocked Count:",
                      userProfile.count.blockedCount.toString() ?? "",
                    ),
                    _buildKeyValuePair(
                      "Critical Count:",
                      userProfile.count.criticalCount.toString() ?? "",
                    ),
                    _buildKeyValuePair(
                      "Expired Delivery Date Count:",
                      userProfile.count.expiredDeliveryDateCount.toString() ?? "",
                    ),
                    _buildKeyValuePair(
                      "Expired Next Follow-Up Date Count:",
                      userProfile.count.expiredNextFollowUpDateCount.toString() ?? "",
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: SizedBox(
                  height: 45,
                  width: 240,
                  child: ElevatedButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) => RateUserDialog(
                          userId: widget.userId,
                          businessId: widget.businessId,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(kprimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Rate User",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ratings",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: height * 0.01),
              if (userProfile != null)
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userProfile?.user?.rating?.length ?? 0,
                  itemBuilder: (context, index) {
                    RatingModel ratingItem = userProfile!.user!.rating![index];
                    return RatingListTile(rating: ratingItem);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildKeyValuePair(String key, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            key,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
