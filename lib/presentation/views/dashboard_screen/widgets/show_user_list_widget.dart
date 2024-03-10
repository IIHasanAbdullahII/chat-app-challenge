import 'package:flash_chat/presentation/views/dashboard_screen/cubit/update_image_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/widgets/contacts_list_tile_widget.dart';
import 'package:flash_chat/presentation/widgets/custom_circular_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../data/model/user_detail/user_detail.dart';
import '../../../widgets/no_freind_found.dart';
import '../../profile_screen/profile_screen.dart';

class showUserListWidget extends StatefulWidget {
  final List<UserDetail> users;

  const showUserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  State<showUserListWidget> createState() => _showUserListWidgetState();
}

class _showUserListWidgetState extends State<showUserListWidget> {

  @override
  void initState() {
    context.read<ImageCubit>().setImageUrl();    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.search),
              const Text(
                "ChatBox",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<ImageCubit, String?>(
                builder: (_, state) {
                  return CustomCircularImageWidget(
                isNetworkImage: true,
                  imageFile: state!,
                  callBack: () {
                    AppRoutes.pushNavigator(ProfileScreen(imageFile: state), context);
                  });
                },
              )
              
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
            child: widget.users.isNotEmpty ? ListView.builder(
                itemCount: widget.users.length,
                itemBuilder: (context, index) {
                  return ContactsListTileWidget(users: widget.users[index]);
                }): NoFreindFound(onClick: () {  },) )
      ],
    );
  }
}


