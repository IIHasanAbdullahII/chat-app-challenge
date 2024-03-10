import 'package:flash_chat/presentation/views/dashboard_screen/cubit/user_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/user_state.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/firebase_client.dart';
import '../../../core/helpers.dart';
import '../../../data/model/user_detail/user_detail.dart';
import 'widgets/show_user_list_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? currentBackPressTime;
  final List<UserDetail> userDetail = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<UserCubit>(context).getUsers();
     
}

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        isDefault: true,
        onClick: () {},
        isFullScreen: true,
        child: _buildBody());
  }

  _buildBody() {
    return WillPopScope(
          onWillPop: onWillPop,
          child: BlocBuilder<UserCubit, UserState>(
            builder: (_, state) {
              if(state is UserSuccess){
                userDetail.clear();
                for(var userDetails in state.users){
                  if(API.user.uid != userDetails.id){
                    userDetail.add(userDetails);
                  }
                }                 
                return showUserListWidget(users : userDetail);
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
          
        );
          
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helpers.showToast(context, "Please press again to exit .");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}


