import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomChangeImageWidget extends StatefulWidget {
  String imageFile;
  double radius;
  final Function(File?) onImageSelected;
  CustomChangeImageWidget({
    super.key,
    required this.imageFile,
     required this.onImageSelected,
    this.radius = 130,
  });

  @override
  State<CustomChangeImageWidget> createState() =>
      _CustomChangeImageWidgetState();
}

class _CustomChangeImageWidgetState extends State<CustomChangeImageWidget> {
  late File? _image = null;
  final picker = ImagePicker();

  void _handleImageSelected(File? image) {
    setState(() {
      _image = image;
    });
    widget.onImageSelected(image); 
  }

  Future showOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Photo Gallery'),
              onTap: () {                
                Navigator.of(context).pop();                
                getImageFromGallery();
              },
            ),
            ListTile(
              title: const Text('Camera'),
              onTap: () {                
                Navigator.of(context).pop();                
                getImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );    
  }
  
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _handleImageSelected(File(pickedFile.path));
      }
    });
  }
  
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _handleImageSelected(File(pickedFile.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
      child: InkWell(
        onTap: () {
          showOptions();
        },
        child: Stack(
          children: [
            ClipOval(
              child: Container(
                width: widget.radius * 2,
                height: widget.radius * 2,
                color: Colors.transparent,
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                height: widget.radius * 2,
                width: widget.radius * 2,
                  imageUrl: widget.imageFile,
                  fit: BoxFit.cover,  
                  placeholder: (context, url) => const CircleAvatar(
                            child: Icon(CupertinoIcons.person, size: 200,)),             
                  errorWidget: (context, url, error) => const CircleAvatar(
                            child: Icon(CupertinoIcons.person, size: 200,)),
                )  
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 37, 151, 136),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
