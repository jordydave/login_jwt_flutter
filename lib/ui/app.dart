import 'package:flutter/material.dart';
import 'package:jwt/injector/injector.dart';
import 'package:jwt/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:jwt/ui/register/register_screen.dart';

import 'dashboarduser/dashboard_user_screen.dart';
import 'login/login_screen.dart';

class App extends StatelessWidget {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();
  @override
  Widget build(BuildContext context) {
    bool _isAlreadyLoggedIn = _sharedPreferencesManager
            .isKeyExists(SharedPreferencesManager.keyIsLogin)
        ? _sharedPreferencesManager.getBool(SharedPreferencesManager.keyIsLogin)
        : false;
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFF06038),
        ),
        home: _isAlreadyLoggedIn ? DashboardUserScreen() : LoginScreen(),
        routes: {
          '/login_screen': (context) => LoginScreen(),
          '/register_screen': (context) => RegisterScreen(),
          '/dashboard_user_screen': (context) => DashboardUserScreen(),
        });
  }
}
