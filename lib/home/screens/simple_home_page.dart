import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/services/shared_preferences_service.dart';
import '../../widgets/buttons/custom_menu_button.dart';

class NoBusinessHomePage extends StatefulWidget {
  const NoBusinessHomePage({super.key});

  @override
  State<NoBusinessHomePage> createState() => _NoBusinessHomePageState();
}

class _NoBusinessHomePageState extends State<NoBusinessHomePage> {
  @override
  void initState() {
    super.initState();
    callInit();
  }

  void callInit() {
    Provider.of<HomeProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<HomeProvider>(context).userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Text("USer does not belong to any business");
  }
}