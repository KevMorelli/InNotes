import 'package:flutter/material.dart';
import 'package:in_notes/core/constants/routes_constants.dart';
import 'package:in_notes/core/locator.dart';
import 'package:in_notes/ui/router.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  await setupLocator();

  runApp(App(initialRoute: Routes.prototype));
}

class App extends StatelessWidget {
  final String initialRoute;

  App({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InNotes',
      theme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.resolveWith<Color>((_) => Colors.blue))),
      navigatorKey: StackedService.navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
