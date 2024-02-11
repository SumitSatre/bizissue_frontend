import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_business_controller.dart';
import 'package:bizissue/business_home_page/widgets/no_business_app_bar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:bizissue/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';

class NoBusinessHomePage extends StatefulWidget {

  @override
  State<NoBusinessHomePage> createState() => _NoBusinessHomePageState();
}

class _NoBusinessHomePageState extends State<NoBusinessHomePage> {
  TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Provider.of<HomeProvider>(context, listen: false);
    final businessController = Provider.of<BusinessController>(context, listen: false);
    final createBusinessController = Provider.of<CreateBusinessProvider>(context, listen: false);
    return Scaffold(
      appBar: NoBusinessAppBar(),
      body: GestureDetector(
        onTap: () {
          // Unfocus any focused text field to dismiss thRe keyboard
          // FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context).pushNamed(MyAppRouteConstants.createBusinessRouteName);
                  },
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create Business',
                            style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Join to get opportunities and manage your team',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Join Business',
                          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Join to get opportunities and manage your team',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20), // Add space between text and PinInputTextField
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust horizontal padding as needed
                          child: Pinput(
                            controller: _codeController,
length: 6,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 20), // Add space between PinInputTextField and SubmitButton
                        ElevatedButton(
                          onPressed: () {
                            createBusinessController.joinBusinessRequest(context, _codeController.text);
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: userModel == null
          ? null
          : MyDrawer(
        name: "${userModel.name}",
      ),
    );
  }
}
