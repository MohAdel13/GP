abstract class RegisterState {}

class RegisterInitState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterPassVisibilityChange extends RegisterState{}

class RegisterConfPassVisibilityChange extends RegisterState{}

class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}