import 'dart:io';

import 'package:flash_chat/core/usecase.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors.dart';
import '../../../../domain/usecase/firebase_usecases/user_info/user_info.dart';

class UserCubit extends Cubit<UserState>{
  final Users users;
  UserCubit({required this.users}): super(UserInitial());

  Future<void> getUsers () async{
    emit(UserLoading());
    final streamResponse = await users.call(NoParams());
    streamResponse.fold(
      (l) {
        if(l is FirebaseAuthExceptionFailure){
          emit(UserFailure(l.message ?? ""));
        } else if (l is ServerFailure){
          emit(UserFailure(l.message ?? ""));
        } else if (l is SocketException){
          emit(UserFailure(l.toString()));
        }
      },  
      (r) {
        r.listen((users) {
          emit(UserSuccess(users: users));
         });
      });
  }
  
}