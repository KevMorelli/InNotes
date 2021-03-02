import 'package:flutter/material.dart';
import 'package:in_notes/core/constants/routes_constants.dart';
import 'package:in_notes/ui/views/prototype.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.prototype:
        return MaterialPageRoute(builder: (_) => PrototypeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
