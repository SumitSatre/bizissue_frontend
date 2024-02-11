import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RateUserDialog extends StatefulWidget {
  final String userId;
  final String businessId;

  const RateUserDialog({
    Key? key,
    required this.userId,
    required this.businessId,
  }) : super(key: key);

  @override
  _RateUserDialogState createState() => _RateUserDialogState();
}

class _RateUserDialogState extends State<RateUserDialog> {
  late TextEditingController _messageController;
  double _rating = 0;
bool _switchValue = false;
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final businessController =
        Provider.of<BusinessController>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rate User",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            Row(
              children: [
                Text(
                  "Anonymous",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                  activeColor: Colors.blue, // Color when switch is on
                  inactiveThumbColor: Colors.grey, // Color of the switch when off
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    businessController.rateUserRequest(
                        context,
                        widget.businessId,
                        widget.userId,
                        _messageController.text,
                        _rating,
                    _switchValue
                    );
                    _messageController.text = "";

                    _submitRating(); // Perform rating submission
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitRating() {
    GoRouter.of(context).pop(); // Close the dialog after submission
  }
}
