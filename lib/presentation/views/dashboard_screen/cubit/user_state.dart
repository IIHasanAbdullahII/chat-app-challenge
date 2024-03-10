
import '../../../../data/model/user_detail/user_detail.dart';

abstract class UserState{
  const UserState();
}

class UserInitial extends UserState{}
class UserLoading extends UserState{}
class UserSuccess extends UserState{
  final List<UserDetail> users;

  UserSuccess({required this.users});
}
class UserEmpty extends UserState{}
class UserFailure extends UserState{
  final String? message;

  UserFailure(this.message);
}