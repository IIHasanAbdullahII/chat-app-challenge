import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();    
    Timer(const Duration(seconds: 5), () {
      precacheImage(const AssetImage('images/background_image.png'), context);
      precacheImage(const AssetImage('images/apple.png'), context);   
      precacheImage(const AssetImage('images/facebook.png'), context); 
      precacheImage(const AssetImage('images/google.png'), context); 
      precacheImage(const AssetImage('images/white_apple.png'), context);  
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.Welcome_Screen, (route) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,          
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/bg2.png',
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.height / 3,
                repeat: ImageRepeat.noRepeat,
              ),
            ],
          ))),
    );
  }
}