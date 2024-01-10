import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.textScaleFactorOf(context);

    final businessController = Provider.of<BusinessController>(context, listen: false);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
                "assets/images/empty_screen.jpeg"),
            height: 250,
            fit: BoxFit.fitHeight,
          ),

          SizedBox(height: height*0.01,),
          Text("Oops!" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),

          SizedBox(height: height*0.005,),

          Text("You haven’t created any issue!!"),

          SizedBox(height: height*0.04,),

//          Center(
//            child: SizedBox(
//              height: 45,
//              width: 240,
//              child: ElevatedButton(
//                onPressed: () {
//                  print("Page Controller: ${businessController.pageController}");
//                  businessController.navigationTapped(0);
//                },
//                style: ButtonStyle(
//                  foregroundColor:
//                  MaterialStateProperty.all<Color>(Colors.white),
//                  backgroundColor: MaterialStateProperty.all<Color>(
//                      submitButtonsColor),
//                  shape:
//                  MaterialStateProperty.all<RoundedRectangleBorder>(
//                    RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25),
//                    ),
//                  ),
//                ),
//                child: const Text(
//                  "Submit",
//                  style: TextStyle(fontSize: 16),
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}