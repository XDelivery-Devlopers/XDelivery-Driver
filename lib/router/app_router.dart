import 'package:edelivery_driver/screens/addphone_screen.dart';
import 'package:edelivery_driver/screens/home_screens.dart';
import 'package:edelivery_driver/screens/otpverification_screen.dart';
import 'package:edelivery_driver/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:edelivery_driver/utilities/constants.dart';
import 'package:edelivery_driver/screens/splash_screen.dart';


import 'screens_argument.dart';

class Router{
   static Route<dynamic> generateRoute(RouteSettings settings) {
     switch (settings.name) {
       case splashscreenRoute:
         return MaterialPageRoute(builder: (_) => SplashScreen());
       case welcomeRoute:
         return MaterialPageRoute(builder: (_) => WelcomeScreen());
       case addphoneRoute:
         return MaterialPageRoute(builder: (_) => AddPhoneScreen());
       case otpverifyRoute:
         final args = settings.arguments as ScreenArguments;
         return MaterialPageRoute(builder: (_) => OtpVerificationScreen(
             phoneNumber:  args.phonenumber,
         ));
       case homeRoute:
         return MaterialPageRoute(builder: (_) => HomeScreen());
       default:
         return MaterialPageRoute(builder: (_) => Scaffold(
                   body: Center(
                       child: Text('No route defined for ${settings.name}')),
                 ));
     }
   }
}