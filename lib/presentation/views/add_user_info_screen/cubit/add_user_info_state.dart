abstract class AddUserInfoState {
  const AddUserInfoState();
}

class  Initial extends AddUserInfoState {}

class  Loading extends AddUserInfoState {}

class  Success extends AddUserInfoState{}

class  Failure extends AddUserInfoState{
  String message;
  Failure(this.message);
}

