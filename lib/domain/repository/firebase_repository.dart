import 'package:dartz/dartz.dart';
import 'package:flash_chat/core/errors.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';

import '../../data/model/user_detail/user_detail.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, bool>> authSignIn(AuthParams params);
  Future<Either<Failure, bool>> authSignUp(AuthParams params);
  Future<Either<Failure,Stream<List<UserDetail>>>> userInfo();
}