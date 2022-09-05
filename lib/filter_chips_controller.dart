import 'package:flutter/material.dart';

class FilterChipsController extends ValueNotifier<List<String>> {
  FilterChipsController() : super([neox]);

  static const neox = 'Neox';

  void add(String selectedValue) {
    if (value.contains(selectedValue)) {
      value.remove(selectedValue);
      if (value.isEmpty) {
        value.add(neox);
      }
    } else {
      if (selectedValue == neox) {
        value = [];
        value.add(selectedValue);
        super.notifyListeners();
      } else {
        value.remove(neox);
        value = [];
        value.add(selectedValue);
      }
    }
    super.notifyListeners();
  }
}
