import 'package:flutter/foundation.dart';

class GlobalVariableModel extends ChangeNotifier {
  bool _hasMessage = false;

  bool get hasMessage => _hasMessage;

  set hasMessage(bool value) {
    _hasMessage = value;
    notifyListeners();
  }
}