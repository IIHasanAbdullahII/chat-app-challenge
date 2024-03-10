import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_info_cubit.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_profile_image_cubit.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/update_image_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/user_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_image_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:flash_chat/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/di.dart' as getIt;

import 'core/navigation/app_routes.dart';




void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getIt.init();
   
  runApp(const FlashChat());}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.sl<AuthCubit>()),
        BlocProvider(create: (_) => getIt.sl<UserCubit>()), 
        BlocProvider(create: (_) => getIt.sl<AddUserInfoCubit>()),    
        BlocProvider(create: (_) => getIt.sl<UpdateUserCubit>()), 
        BlocProvider(create: (_) => getIt.sl<ImageCubit>()),
        BlocProvider(create: (_) => getIt.sl<ProfileImageCubit>()),
        BlocProvider(create: (_) => getIt.sl<AddUserProfileImageCubit>()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getAppRoutes().getRoutes,
      home: const SplashView(),
    ),
    );
    
  }
  AppRoutes getAppRoutes() {
    return AppRoutes();
  }
}
