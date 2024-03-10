import 'package:flash_chat/presentation/views/dashboard_screen/dashboard_screen.dart';
import 'package:flash_chat/presentation/views/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/add_user_info_screen/add_user_info_screen.dart';
import '../../presentation/views/authentication/login_screen/login_screen.dart';
import '../../presentation/views/authentication/registration_screen/registration_screen.dart';

class AppRoutes {
  static const String Welcome_Screen = "/welcome_screen";
  static const String Login_Screen = "/log_in_screen";
  static const String Signup_Screen = "/sign_up_screen";
  static const String Dashboard_Screen = "/dash_board_screen";
  static const String Add_User_Info_Screen = "/add_user_info_screen";

  Route getRoutes (RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Login_Screen:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          
          builder: (context) => const LoginScreen());
      }
      

      case Signup_Screen:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          
          builder: (context) => const RegistrationScreen());
      }

      case Dashboard_Screen:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          
          builder: (context) => const DashboardScreen());
      }     

      case Add_User_Info_Screen:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          
          builder: (context) => const AddUserInfoScreen());
      }

      default:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const WelcomeScreen(),              
              );
        }
    }
  }

  static pushNavigator(Widget widget,BuildContext context){

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
}