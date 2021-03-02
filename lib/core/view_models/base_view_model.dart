import 'package:flutter/material.dart';
import 'package:in_notes/core/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class BaseViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateTo(String route) {
    _navigationService.navigateTo(route);
  }
}
