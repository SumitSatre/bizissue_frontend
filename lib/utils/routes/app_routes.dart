
import 'package:bizissue/auth/screens/signup_screen.dart';
import 'package:bizissue/auth/screens/splash_screen.dart';
import 'package:bizissue/home/screens/home_page.dart';

import '../../auth/screens/login_screen.dart';
import 'app_route_constants.dart';

class AppRoutes {
  static final routes = {
    MyAppRouteConstants.splashscreenRouteName : (context) => const SplashScreen(),
    MyAppRouteConstants.homeRouteName : (context) => HomePage(),
    MyAppRouteConstants.loginRouteName : (context) => LoginScreen(),
    MyAppRouteConstants.signupRouteName : (context) => SignupScreen(),
  };
}
