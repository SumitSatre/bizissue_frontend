import 'package:bizissue/auth/screens/login_screen.dart';
import 'package:bizissue/auth/screens/signup_screen.dart';
import 'package:bizissue/home/screens/home_page.dart';
import 'package:bizissue/business_home_page/screens/business_page.dart';
import 'package:bizissue/utils/error_page.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bizissue/auth/screens/splash_screen.dart';

class MyAppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: MyAppRouteConstants.splashscreenRouteName,
          path: '/',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: SplashScreen());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: '/login',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: LoginScreen());
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.signupRouteName,
          path: '/signup',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: SignupScreen());
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.homeRouteName,
          path: '/home',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: HomePage());
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.businessRouteName,
          path: '/home/business',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: BusinessPage());
          },
        ),

      ],
      // errorPageBuilder: (BuildContext context,GoRouterState state) {
      //   return MaterialPage(child: ErrorPage(errorMessage: "Error"));
      // },
    );
    return router;
  }
}