import 'package:flutter/material.dart';
import 'package:jwt/injector/injector.dart';
import 'package:jwt/ui/app.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(App());
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}
