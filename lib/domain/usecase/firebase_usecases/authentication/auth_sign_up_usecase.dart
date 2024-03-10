import 'package:dartz/dartz.dart';
import 'package:flash_chat/core/usecase.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';

import '../../../../core/errors.dart';
import '../../../repository/firebase_repository.dart';

class AuthSignUpUseCase extends UseCase<bool, AuthParams> {
  final FirebaseRepository _repo;

  AuthSignUpUseCase(this._repo);
  @override
  Future<Either<Failure, bool>> call(AuthParams params) {
   return _repo.authSignUp(params);
  }
   
}

