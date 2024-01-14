import 'package:bizissue/business_home_page/screens/controller/create_business_controller.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:bizissue/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class JoinBusinessPage extends StatefulWidget {
  @override
  _JoinBusinessPageState createState() => _JoinBusinessPageState();
}

class _JoinBusinessPageState extends State<JoinBusinessPage> {
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final createBusinessController = Provider.of<CreateBusinessProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .19),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * .04),
          child: Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 20),
              Text(
                "Join Business",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinInputTextField(
              pinLength: 6,
              keyboardType: TextInputType.text,
              controller: codeController,
              decoration: UnderlineDecoration(
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: PinListenColorBuilder(
                  Colors.black, // Regular color
                  Colors.blue,  // Highlight color when typing
                ),
              ),
              autoFocus: true,
              textInputAction: TextInputAction.done,
              onSubmit: (pin) {
                // Handle the submit button action
                if (pin.length == 6) {
                  // Perform actions with the entered code
                  print('Entered code: $pin');
                  // You can add logic here to process the code
                } else {
                  // Show an error message or take appropriate action
                  print('Invalid code length');
                }
              },
            ),

            SizedBox(height: height*0.04),
            SubmitButton(onPressed: (){
              createBusinessController.joinBusinessRequest(context, codeController.text);
            })
          ],
        ),
      ),
    );
  }
}