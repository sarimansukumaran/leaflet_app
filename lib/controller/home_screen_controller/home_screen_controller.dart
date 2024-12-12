import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaflet_app/controller/home_screen_controller/home_screen_state.dart';

final homeScreenNotifierProvider =
    StateNotifierProvider<HomeScreenControllerNotifier, HomeScreenState>((ref) {
  return HomeScreenControllerNotifier();
});

class HomeScreenControllerNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenControllerNotifier()
      : super(HomeScreenState(height: 150, width: .7, currentindex: 0));
  update(double offset) {
    double newHeight = (150 - (offset / 10)).clamp(100, 150);
    double newWidth = (0.7 - (offset / 1000)).clamp(0.4, 0.7);

    state = state.copywith(height: newHeight, width: newWidth);
  }

  onScreenChange(int index) {
    state = state.copywith(currentIndex: index);
  }
}
