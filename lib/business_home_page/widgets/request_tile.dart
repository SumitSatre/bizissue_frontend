import 'package:bizissue/home/models/user_model.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  final String? logoUrl;
  final String name;
  final ContactNumber contactNumber; // Assuming ContactNumber is a custom type
  final Function() onAccept;
  final Function() onReject;

  const RequestTile({
    this.logoUrl,
    required this.name,
    required this.contactNumber,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16 , right: 16 , top: 5 , bottom: 5),
        child: Row(
          children: [
            // Logo
            CircleAvatar(
              backgroundImage: logoUrl != null ? NetworkImage(logoUrl!) : null, // Handle null logoUrl
              radius: 30.0,
            ),
            const SizedBox(width: 16.0),
            // Name and contact number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text("${contactNumber.countryCode}-${contactNumber.number}", style: const TextStyle(fontSize: 14.0, color: Colors.grey)), // Assuming ContactNumber can be converted to a string
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            // Accept and reject buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: onReject,
                ),

                const SizedBox(width: 8.0),

                IconButton(
                  icon: Icon(Icons.done, color: Colors.green),
                  onPressed: onAccept,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
