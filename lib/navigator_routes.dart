import 'package:flutter/material.dart';
import 'package:login_task/screens/login_screen.dart';
import 'package:login_task/screens/register_screen.dart';

import 'screens/dashboard_screen.dart';

abstract class NavigatorRoutes {
  static MaterialPageRoute materialPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => DashboardScreen());
        break;
      case "/signup":
        return MaterialPageRoute(builder: (context) => RegisterScreen());
        break;
      case "/signin":
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;
      case "/dashboard":
        return MaterialPageRoute(builder: (context) => DashboardScreen());
        break;
      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;
    }
  }
}
