import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';

class BusinessHomePage extends StatefulWidget {
  final String id;

  const BusinessHomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   callInit();
  // }

  void callInit() {
    Provider.of<BusinessController>(context, listen: false).init(widget.id);
  }

  @override
  Widget build(BuildContext context) {

    final businessModel =
        Provider.of<BusinessController>(context).businessModel;

    if(businessModel == null){
      callInit();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final userModel = Provider.of<HomeProvider>(context).userModel;

    return SafeArea(
      child:
          Consumer<BusinessController>(builder: (context, controller, child) {
        return controller.isError
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your token has expired.please login again"),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<BusinessController>(context,
                                  listen: false)
                              .updateisError();
                          SharedPreferenceService().clearLogin();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              MyAppRouteConstants.loginRouteName,
                              (route) => false);
                        },
                        child: const Text("Login  again"))
                  ],
                ),
              )
            : businessModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kprimaryColor,
                    ),
                  )
                : Scaffold(
                    body: ListView.builder(
                      itemCount: businessModel.myTeamIssues.length,
                      itemBuilder: (context, index) {
                        IssueShort issue = businessModel.myTeamIssues[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 2),
                          padding: EdgeInsets.all(8.0),
                          color: Color(0x33D9D9D9),
                          // decoration: BoxDecoration(
                          //   color: Color(0x33D9D9D9),
                          //   border: Border.all(color: Colors.grey),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children : [
                                  Text(
                                    issue.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "Sumit: sir checkout this",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]
                              ),
                              SizedBox(width: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${issue.deliveryDate.toString()}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  // Add any other widgets or icons you may need
                                ],
                              ),
                            ],
                          ),
                        );

                      },
                    ),
                  );
      }),
    );
  }
}
