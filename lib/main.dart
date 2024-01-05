import 'package:bizissue/auth/screens/controllers/login_provider.dart';
import 'package:bizissue/auth/screens/controllers/signup_provider.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser:MyAppRouter.returnRouter().routeInformationParser,
        routeInformationProvider: MyAppRouter.returnRouter().routeInformationProvider,
        routerDelegate: MyAppRouter.returnRouter().routerDelegate,
      ),
    );
  }
}
