import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaflet_app/controller/bottom_navbar_screen_controller/bottom_navbar_screen_state.dart';

final bottomNavbarScreenProvider = StateNotifierProvider((ref) {
  return BottomNavbarScreenStateNotifier();
});

class BottomNavbarScreenStateNotifier
    extends StateNotifier<BottomNavbarScreenState> {
  BottomNavbarScreenStateNotifier()
      : super(BottomNavbarScreenState(currentindex: 0));
  onScreenChange(int index) {
    state = state.copywith(val: index);
  }
}
