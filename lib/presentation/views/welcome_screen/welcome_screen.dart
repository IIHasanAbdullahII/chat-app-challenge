import 'package:flash_chat/core/navigation/app_routes.dart';
import 'package:flash_chat/presentation/widgets/animated_button_widget.dart';
import 'package:flash_chat/presentation/widgets/animated_text_widget.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';

import 'package:flutter/material.dart';

import '../../widgets/custom_divider_widget.dart';
import '../../widgets/custom_row_images_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    

    return BaseWidget(
      isDefault: true,
      onClick: () {},
      isBackgroundImage: true,
      height: size.height,
      width: size.width,
      imageLocation: "images/background_image.png",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 50.0, end: 1.0),
              duration: Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
              child: RichText(
                text: const TextSpan(
                  text: 'Connect Friends ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Easily & Quickly',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 50.0, end: 1.0),
              duration: Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
              child: const Text(
                "Our chat app is perfect to stay connected with friends and family",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomRowImagesWidget(
              firstAssetImage: 'images/facebook.png', 
              secondAssetImage: 'images/google.png', 
              thirdAssetImage: 'images/white_apple.png',),
            const SizedBox(
              height: 20,
            ),
            const CustomDivider(),
            const SizedBox(
              height: 20,
            ),
            AnimatedButton(
                text: "Signup with E-mail",
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.Signup_Screen, (route) => false);
                }),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AnimatedText(
                text: "Existing account. Log In",
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.Login_Screen, (route) => false);                  
                },
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}




