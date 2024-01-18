import 'package:bizissue/Issue/screens/issue_page.dart';
import 'package:bizissue/auth/screens/login_screen.dart';
import 'package:bizissue/auth/screens/signup_screen.dart';
import 'package:bizissue/auth/screens/verify_login_otp.dart';
import 'package:bizissue/auth/screens/verify_signup_otp.dart';
import 'package:bizissue/business_home_page/screens/create_business.dart';
import 'package:bizissue/business_home_page/screens/join_business.dart';
import 'package:bizissue/business_home_page/screens/requests_screen.dart';
import 'package:bizissue/group/screens/create_group.dart';
import 'package:bizissue/group/screens/group_detailed_page.dart';
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
          path: '/home/business/requests/:businessId',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: BusinessRequestsPage(
              businessId: state.params['businessId']!,
            ));
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.verifyRouteName,
          path: '/login/verify/:VerificationId',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(
                child: MyOtp(
                  VerificationId: state.params['VerificationId']!,
                ));
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.verifySignUpRouteName,
          path: '/signup/verify/:VerificationId',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(
                child: MySignUpOtp(
                  VerificationId: state.params['VerificationId']!,
                ));
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.issuePageRouteName,
          path: '/business/issue/:issueId/:businessId',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(
                child: IssuePage(
                  issueId: state.params['issueId']!,
                  businessId: state.params['businessId']!,
                ));
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.groupDetailedRouteName,
          path: '/business/group/detailed/:groupId/:groupName',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(
                child: GroupDetailedPage(
                  groupId: state.params['groupId']!,
                  groupName: state.params['groupName']!
                ));
          },
        ),

        GoRoute(
          name: MyAppRouteConstants.createGroupRouteName,
          path: '/create/group',
          pageBuilder: (BuildContext context,GoRouterState state) {
            return MaterialPage(child: CreateGroupPage());
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