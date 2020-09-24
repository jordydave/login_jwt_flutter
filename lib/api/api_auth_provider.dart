import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/model/diagnostic/diagnostic.dart';
import 'package:jwt/model/login/login_body.dart';
import 'package:jwt/model/refreshtoken/refresh_token_body.dart';
import 'package:jwt/model/register/register.dart';
import 'package:jwt/model/token/token.dart';
import 'package:jwt/utils/dio_logging_interceptors.dart';

class ApiAuthProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://project.bintorobuild.co.id/api/v2/';
  final String clientId = 'oke';
  final String clientSecret = 'oke';

  ApiAuthProvider() {
    _dio.options.baseUrl = _baseUrl;

    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  // Future<DropDown> dropDownItem() async {
  //   try {
  //     final response = await _dio.get(
  //       'select_projects',
  //       options: Options(headers: {
  //         'requirestoken': true,
  //       }),
  //     );
  //     return DropDown.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     _printError(error, stacktrace);
  //     return DropDown.withError('$error');
  //   }
  // }

  Future<Diagnostic> registerUser(Register register) async {
    try {
      final response = await _dio.post(
        'register/user',
        data: register.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return Diagnostic.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Diagnostic.withError('$error');
    }
  }

  Future<Token> loginUser(LoginBody loginBody) async {
    try {
      final response = await _dio.post(
        'login',
        data: FormData.fromMap(loginBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<Token> refreshAuth(RefreshTokenBody refreshTokenBody) async {
    try {
      final response = await _dio.post(
        'validate_login',
        data: FormData.fromMap(refreshTokenBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  // Future<User> getAllUsers() async {
  //   try {
  //     print('getAllUsers');
  //     final response = await _dio.post(
  //       'validate_login',
  //       options: Options(
  //         followRedirects: false,
  //         validateStatus: (status) {
  //           return status < 500;
  //         },
  //         headers: {
  // 'requirestoken': true,
  //         },
  //       ),
  //     );
  //     return User.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     _printError(error, stacktrace);
  //     return User.withError('$error');
  //   }
  // }

//   Future<Welcome> getData() async {
//     print('getData');
//     final response = await _dio.get(
//       'https://project.bintorobuild.co.id/api/v2/select_projects',
//       options: Options(
//         headers: {
//           'requirestoken': true,
//         },
//       ),
//     );
//     return Welcome.fromJson(response.data);
//   }

//   Future<Welcome> getAllData() async {
//     final response = await http.get(
//         'https://project.bintorobuild.co.id/api/v2/select_projects',
//         headers: {
  // HttpHeaders.authorizationHeader:
  //     "$SharedPreferencesManager.keyAccessToken",
//         });
//     final responseJson = json.decode(response.body);
//     return Welcome.fromJson(responseJson);
//   }
// }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error:$error & stackTrace:$stacktrace');
  }
}
