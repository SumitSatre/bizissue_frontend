import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:flutter/material.dart';

class DeclinedRequestTile extends StatelessWidget {
  final DeclinedRequestUser declinedRequestUser;

  const DeclinedRequestTile({Key? key, required this.declinedRequestUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Add elevation for a shadow effect
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              declinedRequestUser.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Reason: ${declinedRequestUser.reason}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "Declined Date: ${declinedRequestUser.declinedDate}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "Contact Number: ${declinedRequestUser.contactNumber.countryCode} ${declinedRequestUser.contactNumber.number}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
