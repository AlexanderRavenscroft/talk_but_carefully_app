import 'package:flutter/foundation.dart';

class ToggleProvider extends ChangeNotifier {
  bool _isToggled = false;

  bool get isToggled => _isToggled;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}
