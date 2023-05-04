// model/model_input_place.dart
import 'package:flutter/material.dart';

class InputPlaceModel extends ChangeNotifier {
  String place = "";

  void setPlace(String place) {
    this.place = place;
    notifyListeners();
  }
}