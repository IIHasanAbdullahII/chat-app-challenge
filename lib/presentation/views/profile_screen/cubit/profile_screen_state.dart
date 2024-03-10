abstract class UpdateUserState {
  const UpdateUserState();
}

class  Initial extends UpdateUserState {}

class  Loading extends UpdateUserState {}

class  Success extends UpdateUserState{}

class  Failure extends UpdateUserState{
  String message;
  Failure(this.message);
}

class  LogOutLoading extends UpdateUserState {}

class  LogOutSuccess extends UpdateUserState{}