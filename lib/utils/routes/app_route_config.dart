import 'package:bizissue/auth/screens/login_screen.dart';
import 'package:bizissue/auth/screens/signup_screen.dart';
import 'package:bizissue/business_home_page/screens/create_business.dart';
import 'package:bizissue/business_home_page/screens/join_business.dart';
import 'package:bizissue/business_home_page/screens/requests_screen.dart';
import 'package:bizissue/home/screens/home_page.dart';
import 'package:bizissue/business_home_page/screens/business%20home/business_page.dart';
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

        GoRoute(
          name: MyAppRouteConstants.createBusinessRouteName,
          path: '/create/business',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: CreateBusinessPage());
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.joinBusinessRouteName,
          path: '/join/business',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: JoinBusinessPage());
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.businessRequestsRouteName,
          path: '/home/business/requests',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: BusinessRequestsPage());
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