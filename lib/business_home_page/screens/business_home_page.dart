import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
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

  @override
  void initState() {
    super.initState();
    callInit();
  }

  void callInit() {
    Provider.of<BusinessController>(context, listen: false).init(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Consumer<HomeProvider>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(71),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomMenuButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Text(controller.selectedBusiness),

            drawer: userModel == null
                ? null
                : MyDrawer(
              name:
              "${(userModel.name)}",
            ),
          );
        }
      ),
    );
  }
}
