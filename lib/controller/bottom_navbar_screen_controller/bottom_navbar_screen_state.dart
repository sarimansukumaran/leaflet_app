import 'package:flutter/material.dart';

class BottomNavbarScreenState {
  int currentindex;
  BottomNavbarScreenState({required this.currentindex});

  BottomNavbarScreenState copywith({int? val}) {
    return BottomNavbarScreenState(currentindex: val ?? 0);
  }
}
