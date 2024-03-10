import 'package:flash_chat/presentation/widgets/custom_circular_image_widget.dart';
import 'package:flutter/material.dart';

import '../../core/helpers.dart';

class CustomRowImagesWidget extends StatelessWidget {
  final String firstAssetImage;
  final String secondAssetImage;
  final String thirdAssetImage;
   const CustomRowImagesWidget({
    super.key, required this.firstAssetImage, required this.secondAssetImage, required this.thirdAssetImage,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularImageWidget(
            imageFile: firstAssetImage,
            callBack: () {},
          ),
          const SizedBox(
            width: 15.0,
          ),
          CustomCircularImageWidget(
              imageFile: secondAssetImage,
              callBack: () {
                Helpers.handleGoogleSignIn(context);
              }),
          const SizedBox(
            width: 15.0,
          ),
          CustomCircularImageWidget(
              imageFile: thirdAssetImage, callBack: () {})
        ],
      ),
    );
  }
}