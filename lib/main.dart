import 'package:edelivery_driver/router/app_router.dart';
import 'package:edelivery_driver/utilities/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // initialRoute: splashscreenRoute,
      initialRoute: homeRoute,
      onGenerateRoute: Router.generateRoute ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
