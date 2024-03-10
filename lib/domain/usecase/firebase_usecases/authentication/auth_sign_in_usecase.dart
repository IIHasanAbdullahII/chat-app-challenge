import 'package:dartz/dartz.dart';

import '../../../../core/errors.dart';
import '../../../../core/usecase.dart';
import '../../../repository/firebase_repository.dart';

class AuthSignInUseCase extends UseCase<bool, AuthParams> {
  final FirebaseRepository _repo;

  AuthSignInUseCase(this._repo);
  
  @override
  Future<Either<Failure, bool>> call(AuthParams params) {    
    return _repo.authSignIn(params);
  }
}

class AuthParams{
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}