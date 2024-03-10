import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flash_chat/presentation/widgets/custom_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/model/user_detail/user_detail.dart';
import 'widgets/message_bubble_widget.dart';

class ChatScreen extends StatefulWidget {
  final UserDetail users;
  ChatScreen({super.key, required this.users});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _newMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      isDefault: false,
      isBackButton: true,
      isFullScreen: true,
      isTitle: true,
      userImage: widget.users.image,
      title: widget.users.name!,
      onClick: (){},
      isAppBar: true,      
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index){
                return MessageBubble(isMe: false, text: "Hey", time: Timestamp.now(), sender:  widget.users.name!,);
              }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormWidget(
                    inputAction: TextInputAction.send,
                    isEnabled: true,
                    iconData: Icons.message,
                    text: "new message", 
                    controller: _newMessageController,                  
                    ),
                ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 37, 151, 136),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.send,
                        color: Colors.white,                      
                        size: 35,),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ));
  }
}