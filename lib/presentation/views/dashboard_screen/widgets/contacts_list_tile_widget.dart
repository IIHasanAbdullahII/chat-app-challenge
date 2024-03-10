import 'package:flash_chat/presentation/views/dashboard_screen/widgets/custom_list_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/user_detail/user_detail.dart';

class ContactsListTileWidget extends StatefulWidget {
  UserDetail users;
  ContactsListTileWidget({
    super.key,
    required this.users,
  });

  @override
  State<ContactsListTileWidget> createState() => _ContactsListTileWidgetState();
}

class _ContactsListTileWidgetState extends State<ContactsListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(users: widget.users,);
  }
}