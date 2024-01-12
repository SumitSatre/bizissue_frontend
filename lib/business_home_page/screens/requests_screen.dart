import 'package:bizissue/business_home_page/widgets/empty_screen.dart';
import 'package:bizissue/business_home_page/widgets/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_requests_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';

class BusinessRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final businessRequestController = Provider.of<BusinessRequestsProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02, horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 20),
              Text(
                "Requests",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<RequestUserModel>>(
              future: businessRequestController.getRequestsList(homeController.selectedBusiness),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text('Error loading data'));
                } else {
                  List<RequestUserModel> userList = snapshot.data!;

                  if(userList.length < 1){
                  return Center(child: EmptyScreen());
                  }

                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      RequestUserModel user = userList[index];
                      return RequestTile(name: user.name, contactNumber: user.contactNumber, onAccept: () {}, onReject: () {});
                    },
                  );
                }
              },
            ),
          ),

         // Text(
         //   "History",
         //   style: TextStyle(
         //     color: Colors.black,
         //     fontFamily: "Poppins",
         //     fontWeight: FontWeight.bold,
         //     fontSize: 15,
         //   ),
         // ),
        ],
      ),
    );
  }
}
