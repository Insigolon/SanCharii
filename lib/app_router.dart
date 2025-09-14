import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Add this import

// Import all screens
import 'features/splash/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup.dart';
import 'features/auth/screens/role_selec.dart';
import 'features/home/screens/conductor_dash.dart';
import 'features/auth/screens/conductor_info.dart';
import 'features/home/screens/dest.dart';
import 'features/home/screens/passenger.dart';
import 'features/home/screens/slom.dart';
import 'features/home/screens/route.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String roleSelec = '/roleSelec';
  static const String conductorDash = '/conductorDash';
  static const String conductorInfo = '/conductorInfo';
  static const String dest = '/dest';
  static const String passenger = '/passenger';
  static const String slom = '/slom';
  static const String route = '/route';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case roleSelec:
        final userEmail = settings.arguments as String?; //  Expect a String
        return MaterialPageRoute(
          builder: (_) => RoleSelecScreen(userEmail: userEmail ?? ''),
        );

      case conductorDash:
        return MaterialPageRoute(builder: (_) => ConductorDashScreen());
      case conductorInfo:
        return MaterialPageRoute(builder: (_) => ConductorInfoScreen());
      case dest:
        return MaterialPageRoute(builder: (_) => DestScreen());
      case passenger:
        return MaterialPageRoute(builder: (_) => PassengerScreen());
      case slom:
        return MaterialPageRoute(builder: (_) => SlomScreen());
      case route:
        return MaterialPageRoute(builder: (_) => RouteScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('404: ${settings.name} not found')),
          ),
        );
    }
  }
}
