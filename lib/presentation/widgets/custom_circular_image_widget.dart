import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularImageWidget extends StatelessWidget {
  String imageFile;
  VoidCallback callBack;
  double radius;
  bool isNetworkImage;
  CustomCircularImageWidget({
    super.key,
    required this.imageFile,
    required this.callBack,
    this.radius = 25,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: ClipOval(
        child: isNetworkImage
            ? CachedNetworkImage(
              height: radius * 2,
              width: radius * 2,
                imageUrl: imageFile,
                fit: BoxFit.cover, 
                placeholder: (context, url) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person,)),                
                errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    )
                        
            : imageFile.isNotEmpty ? 
            CircleAvatar(
                radius: radius,
                backgroundColor: Colors.transparent,
                foregroundImage: AssetImage(imageFile),
              ) : const Icon(Icons.person, size: 35,),
      ),
    );
  }
}
