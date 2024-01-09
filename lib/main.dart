import 'package:bizissue/auth/screens/controllers/login_provider.dart';
import 'package:bizissue/auth/screens/controllers/signup_provider.dart';
import 'package:bizissue/auth/screens/splash_screen.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/business_home_page/screens/controller/create_issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_config.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BusinessController()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => CreateIssueProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: MyAppRouter.returnRouter().routeInformationParser,
        routeInformationProvider: MyAppRouter.returnRouter().routeInformationProvider,
        routerDelegate: MyAppRouter.returnRouter().routerDelegate,
        theme: ThemeData.light().copyWith(primaryColor: kprimaryColor),
      ),
    );
  }
}
