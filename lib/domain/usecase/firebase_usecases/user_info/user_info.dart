import 'package:dartz/dartz.dart';
import 'package:flash_chat/core/errors.dart';
import 'package:flash_chat/core/usecase.dart';
import 'package:flash_chat/domain/repository/firebase_repository.dart';

import '../../../../data/model/user_detail/user_detail.dart';

class Users extends UseCase<Stream<List<UserDetail>>, NoParams>{
  final FirebaseRepository _repo;

  Users(this._repo);
  @override
  Future<Either<Failure, Stream<List<UserDetail>>>> call(params) {
    return _repo.userInfo();
  }

}