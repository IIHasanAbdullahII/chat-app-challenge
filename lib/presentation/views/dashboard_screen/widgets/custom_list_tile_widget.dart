import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_chat/core/navigation/app_routes.dart';
import 'package:flash_chat/presentation/views/chat_screen/chat_screen.dart';
import 'package:flash_chat/presentation/widgets/custom_circular_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/user_detail/user_detail.dart';

class CustomListTileWidget extends StatelessWidget {
  UserDetail users;
  CustomListTileWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {    
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 8,top: 8,bottom: 8),
          child: SizedBox(
            height: 40,
            width: 40,
            child: SlidableAction(    
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(50),
            onPressed: (context){},
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            icon: Icons.notifications_outlined,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: SlidableAction(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(50),
            onPressed: (context){},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            ),
          ),
        ),        
      ]),
      child: InkWell(
        onTap: () {
          AppRoutes.pushNavigator(ChatScreen(users: users,), context);
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: CustomCircularImageWidget(isNetworkImage: true ,imageFile: users.image! , 
          callBack: (){
            showDialog(
              context: context,
              builder: (BuildContext context) { 
                Size size = MediaQuery.of(context).size;
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                insetPadding: const EdgeInsets.all(8.0),
                content: SizedBox(
                  height: size.height * 0.5,
                  width: size.width * 0.8,
                  child: CachedNetworkImage(              
                imageUrl: users.image!,
                fit: BoxFit.cover,               
                errorWidget: (context, url, error) => const Icon(CupertinoIcons.person, size: 200,),
              ) ,
                ),
              );
               },
            );
          }),
          // trailing: Column(
          //   children: [
          //     const Text("2 min ago"),
          //     const SizedBox(height: 10,),
          //     Container(
          //       height: 25,
          //       width: 25,                
          //       decoration: BoxDecoration(
          //         color: const Color(0xFFFE4A49),
          //         borderRadius: BorderRadius.circular(50)
          //       ),
          //       child: const Center(
          //         child: Text("1", style: TextStyle(
          //           color: Colors.white
          //         ),),
          //       ),
          //     ),
          //   ],
          // ),
          title: Text(users.name!),
          subtitle: const Text("How are you?"),
        ),
      ),
    );
  }
}