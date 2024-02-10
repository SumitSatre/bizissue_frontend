import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:flutter/material.dart';

class RatingListTile extends StatelessWidget {
  final RatingModel rating;

  RatingListTile({required this.rating});

  @override
  Widget build(BuildContext context) {
    String formattedDate = "${rating.date.day}/${rating.date.month}/${rating.date.year}";

    return ListTile(
      title: Text("Rating: ${rating.rating}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Message: ${rating.message}"),
          Text("Given By: ${rating.givenBy.name}"), // Assuming 'name' is a property of GivenBy
        ],
      ),
      trailing: Text("Date: $formattedDate"),
      onTap: () {
        // Add onTap functionality here if needed
      },
    );
  }
}
