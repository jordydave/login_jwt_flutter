import 'package:jwt/api/api_auth_repository.dart';
import 'package:jwt/model/diagnostic/diagnostic.dart';
import 'package:jwt/model/register/register.dart';
import 'package:bloc/bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}

class RegisterSuccess extends RegisterState {}

class RegisterEvent {
  final Register register;

  RegisterEvent(this.register);
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiAuthRepository apiAuthRepository = ApiAuthRepository();

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    Register register = event.register;
    String username = register.username;
    String password = register.password;

    if (username == null || username.isEmpty) {
      print('username is required');
      yield RegisterFailure('Username is required');
      return;
    } else if (password == null || password.isEmpty) {
      yield RegisterFailure('Password is required');
      return;
    }
    yield RegisterLoading();
    Diagnostic diagnostic = await apiAuthRepository.postRegisterUser(register);
    if (diagnostic.error != null) {
      yield RegisterFailure('${diagnostic.error}');
      return;
    }
    yield RegisterSuccess();
  }
}
