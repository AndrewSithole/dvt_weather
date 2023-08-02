import 'package:flutter/material.dart';

import 'package:dvt_weather/presentation/screens/app_home_screen.dart';
import 'package:dvt_weather/presentation/screens/app_splash_screen.dart';


class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final Object? key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const AppSplashScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => AppHomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => AppHomeScreen(),
        );
    }
  }
}
