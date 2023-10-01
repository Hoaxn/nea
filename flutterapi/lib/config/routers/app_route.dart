import 'package:flutterapi/features/auth/presentation/view/login_screen.dart';
import 'package:flutterapi/features/nea_api/presentation/view/nea_api_screen.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String loginRoute = '/login';

  static getApplicationRoute() {
    return {
      homeRoute: (context) => const NeaApiScreen(),
      loginRoute: (context) => const LoginScreen(),
    };
  }
}
