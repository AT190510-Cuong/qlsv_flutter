import 'package:flutter/cupertino.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;

  void updatescreen() {
    status = 0;
    notifyListeners();
  }

  void displaySpinner() {
    status = 1;
    notifyListeners();
  }

  void hideSpinner() {
    status = 0;
    notifyListeners();
  }
}
