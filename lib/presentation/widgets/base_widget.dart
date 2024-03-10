import 'package:flash_chat/presentation/widgets/custom_circular_image_widget.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget? child;
  bool isAppBar;
  bool isInnerFull;
  bool isFullScreen;
  bool isBackgroundImage;
  double height;
  double width;
  String imageLocation;
  List<Widget> action;
  bool isTitle;
  String? userImage;
  VoidCallback onClick;
  String title;
  String subtitle;
  bool isDefault;
  bool isImageRequired;
  bool isSubTitle;
  bool isBackButton;
  BaseWidget({
    super.key, 
    required this.child,
    this.isAppBar = false,
    this.isInnerFull = false,
    this.isFullScreen = false,
    this.isBackgroundImage = false,
    this.height = 100,
    this.width = 100,
    this.imageLocation = "images/logo.png",
    this.action = const [],
    this.isTitle = false,
    this.userImage = "images/logo.png",
    required this.onClick,
    this.title = "",
    this.subtitle = "",
    this.isSubTitle = false,
    required this.isDefault,
    this.isImageRequired = true,
    this.isBackButton = true,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBar ? 
      AppBar(
        automaticallyImplyLeading: isDefault ? true : false,
          title: isTitle ?           
          Row(
            children: [
              isBackButton ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ) : const SizedBox(),
                
              isImageRequired ? CustomCircularImageWidget(isNetworkImage: true, imageFile: userImage!, callBack: onClick) : const SizedBox(),
              isImageRequired? const SizedBox(width: 10,) : const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, 
                  style: const TextStyle(
                    fontSize: 20,

                  ),),
                  isSubTitle ? Text(subtitle) : const SizedBox(),
                ],
              )
            ],
          )
           : null,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,          
          elevation: 0,
          actions: action,
        ) : null,
      
      body: SafeArea(
        child: Padding(
          padding: isInnerFull ? const EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 5) : 
          isFullScreen ? const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5) : 
          const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: isBackgroundImage ? Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageLocation),
          fit: BoxFit.cover)
        ),
          child: child,
        ) : Container(
          child: child,
        ),
        )
        ),
    );
  }
}