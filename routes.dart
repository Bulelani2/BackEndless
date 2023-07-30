/**
 * This code imports several pages and creates a RouteManager class with a generateRoute function.
 * The function takes in a RouteSettings object and returns a MaterialPageRoute object based on the name of the route.
 */
import 'package:flutter/material.dart';
import 'package:reflections_app/pages/loading.dart';
import 'package:reflections_app/pages/login.dart';
import 'package:reflections_app/pages/reflection_page.dart';
import 'package:reflections_app/pages/reflections_view.dart';
import 'package:reflections_app/pages/register.dart';
import 'package:reflections_app/pages/unit_create.dart';
import 'package:reflections_app/pages/units_view.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String reflectionPage = '/reflectionPage';
  static const String loadingPage = '/loadingPage';
  static const String unitViewPage = '/unitViewPage';
  static const String reflectionViewPage = '/reflectionViewPage';
  static const String unitCreatePage = '/unitCreatePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case unitViewPage:
        return MaterialPageRoute(
          builder: (context) => UnitsPage(),
        );
      case reflectionViewPage:
        return MaterialPageRoute(
          builder: (context) => ReflectionsPage(),
        );
      case unitCreatePage:
        return MaterialPageRoute(
          builder: (context) => UnitsCreatePage(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => Register(),
        );

      case reflectionPage:
        return MaterialPageRoute(
          builder: (context) => ReflectionPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => Loading(),
        );

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
