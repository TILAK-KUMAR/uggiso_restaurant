import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/Widgets/AddMenu.dart';
import 'package:uggiso_restaurant/Widgets/AddNewHotelScreen.dart';
import 'package:uggiso_restaurant/Widgets/HomeScreen.dart';

import 'Widgets/RegisterUserScreen.dart';
import 'Widgets/SignUpScreen.dart';
import 'Widgets/VerifyOtp.dart';
import 'Widgets/splash.dart';


class AppRoutes {
  static const String initialRoute = '/';


  static const String signupScreen = '/signup_screen';

  static const String verifyOtp = '/verify_otp';

  static const String homeScreen = '/home_screen';

  static const String registerUser = '/register_user';

  static const String settingsScreen = '/settings';

  static const String yourOrders = '/app_navigation_screen';

  static const String helpCenter = '/help_center';

  static const String aboutUs = '/about_us';

  static const String addNewHotel = '/add_new_hotel';

  static const String dashboard = '/dashboard_home';

  static const String addNewMenuItem = '/add_new_menu_item';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case verifyOtp:
        return MaterialPageRoute(builder: (_) => const VerifyOtp());
      case registerUser:
        return MaterialPageRoute(builder: (_) => const RegisterUserScreen());

      case addNewHotel:
        return MaterialPageRoute(builder: (_) => const AddNewHotelScreen());

      case dashboard:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case addNewMenuItem:
        return MaterialPageRoute(builder: (_) => const AddMenu());
      default:
        // If there is no such named route in the switch statement, e.g. /randomRoute
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
