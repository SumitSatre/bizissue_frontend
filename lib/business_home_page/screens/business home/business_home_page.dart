import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/dropdown_lists.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/widgets/appBar.dart';
import 'package:bizissue/business_home_page/widgets/toggle_switch.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/services/shared_preferences_service.dart';
import '../../../widgets/buttons/custom_menu_button.dart';

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

  bool switchToggle = false;

  @override
  Widget build(BuildContext context) {
    final businessModel =
        Provider.of<BusinessController>(context).businessModel;

    if (businessModel == null) {
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
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Filters:"),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(switchToggle
                                        ? "My Issues"
                                        : "MyTeamIssues"),
                                  )),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              ToggleSwitch(isSwitched: switchToggle),
                              SizedBox(width: 5),
                              SizedBox(
                                height: 36,
                                width: width * 0.28,
                                child: Container(
                                  height: 36,
                                  width: width * 0.78,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      icon: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      elevation: 4,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      // value: ,
                                      onChanged: (p0) {},
                                      items:
                                          BCDList.map<DropdownMenuItem<String>>(
                                              (String s) {
                                        return DropdownMenuItem<String>(
                                          value: s,
                                          child: Text("  $s"),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                    //    Expanded(
                    //      child: ListView.builder(
                    //        itemCount: businessModel.myTeamIssues.length,
                    //        itemBuilder: (context, index) {
                    //          IssueShort issue =
                    //              businessModel.myTeamIssues[index];
                    //          return ;
                    //        },
                    //      ),
                    //    ),
                     ],
                    ),
                  );
      }),
    );
  }
}
