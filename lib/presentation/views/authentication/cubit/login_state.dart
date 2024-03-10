abstract class AuthState {
  const AuthState();
}

class LoginInitial extends AuthState{
 
}

class LoginLoading extends AuthState {
 
}


class LoginSuccess extends AuthState {
  
}


class LoginFailure extends AuthState {
  final String? message;

  LoginFailure(this.message);
}