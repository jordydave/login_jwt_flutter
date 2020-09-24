import 'package:jwt/api/api_auth_provider.dart';
import 'package:jwt/model/diagnostic/diagnostic.dart';
import 'package:jwt/model/login/login_body.dart';
import 'package:jwt/model/refreshtoken/refresh_token_body.dart';
import 'package:jwt/model/register/register.dart';
import 'package:jwt/model/token/token.dart';

class ApiAuthRepository {
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<Diagnostic> postRegisterUser(Register register) =>
      _apiAuthProvider.registerUser(register);

  Future<Token> postLoginUser(LoginBody loginBody) =>
      _apiAuthProvider.loginUser(loginBody);

  Future<Token> postRefreshAuth(RefreshTokenBody refreshTokenBody) =>
      _apiAuthProvider.refreshAuth(refreshTokenBody);

  // Future<DropDown> getDropDownItem() => _apiAuthProvider.dropDownItem();
  // Future<User> fetchAllUsers() => _apiAuthProvider.getAllUsers();

  // Future<Welcome> getDataAll() => _apiAuthProvider.getAllData();
}
