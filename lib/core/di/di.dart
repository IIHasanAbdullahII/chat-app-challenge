import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_up_usecase.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/user_info/user_info.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_info_cubit.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_profile_image_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/update_image_cubit.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/user_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_image_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/firebase_repository_imp.dart';
import '../../domain/repository/firebase_repository.dart';
import '../../domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';
import '../../presentation/views/authentication/cubit/login_cubit.dart';
import '../api/firebase_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits

  sl.registerFactory(() => AuthCubit(signInUseCase: sl(), signUpUseCase: sl(),),);
  sl.registerFactory(() => UserCubit(users: sl()),);
  sl.registerFactory(() => AddUserInfoCubit(),);
  sl.registerFactory(() => UpdateUserCubit(),);
  sl.registerFactory(() => ImageCubit(),);
  sl.registerFactory(() => ProfileImageCubit(),);
  sl.registerFactory(() => AddUserProfileImageCubit(),);

  // Use Cases  
  sl.registerLazySingleton(() => AuthSignInUseCase(sl()));
  sl.registerLazySingleton(() => AuthSignUpUseCase(sl()));
  sl.registerLazySingleton(() => Users(sl()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl());

  // Externals
  sl.registerLazySingleton<API>(() => API());
}
