import 'dart:io';

import 'package:flash_chat/core/errors.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_up_usecase.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthSignInUseCase signInUseCase;
  final AuthSignUpUseCase signUpUseCase;
  AuthCubit({required this.signInUseCase, required this.signUpUseCase}) : super(LoginInitial());

  Future<void> signInUser(AuthParams params) async {
    emit(LoginLoading());
    final data = await signInUseCase.call(params);
    return data.fold(
      (l) {
        if (l is FirebaseAuthExceptionFailure) {
          if (l.message == "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
            emit(LoginFailure("A network error has occurred. Please try again later"));
          } else {
            emit(LoginFailure(l.message ?? ""));
          }
        } else if (l is ServerFailure) {
          emit(LoginFailure(l.message ?? ""));
        } else if (l is SocketException) {
          emit(LoginFailure("A network error has occurred"));
        } else {
          emit(LoginFailure("An error occurred"));
        }
      },
      (r) => emit(LoginSuccess()),
    );
  }
  
  Future<void> signUpUser(AuthParams params) async {
    emit(LoginLoading());
    final data = await signUpUseCase.call(params);
    return data.fold(
      (l) {
        if (l is FirebaseAuthExceptionFailure) {
          if (l.message == "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
            emit(LoginFailure("A network error has occurred"));
          } else {
            emit(LoginFailure(l.message ?? ""));
          }
        } else if (l is ServerFailure) {
          emit(LoginFailure(l.message ?? ""));
        } else if (l is SocketException) {
          emit(LoginFailure("A network error has occurred"));
        } else {
          emit(LoginFailure("An error occurred"));
        }
      },
      (r) => emit(LoginSuccess()));
    
  }
}