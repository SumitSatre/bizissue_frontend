import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:flutter/material.dart';

class RatingListTile extends StatelessWidget {
  final RatingModel rating;

  RatingListTile({required this.rating});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${rating.date.day}/${rating.date.month}/${rating.date.year}";

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200], // Background color
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rating: ${rating.rating}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Message: ${rating.message}",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  "Given By: ${rating.givenBy.name}",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Date: $formattedDate",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
