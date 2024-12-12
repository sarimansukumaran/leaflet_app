import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaflet_app/controller/bottom_navbar_screen_controller/bottom_navbar_screen_controller.dart';
import 'package:leaflet_app/controller/bottom_navbar_screen_controller/bottom_navbar_screen_state.dart';
import 'package:leaflet_app/view/home_screen/home_screen.dart';

class BottomNavbarScreen extends ConsumerWidget {
  const BottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List screens = [
      HomeScreen(),
      Container(
        color: Colors.white,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.black,
      ),
    ];
    final bottomNavbarScreenState =
        ref.watch(bottomNavbarScreenProvider) as BottomNavbarScreenState;
    return Scaffold(
      body: screens[bottomNavbarScreenState.currentindex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavbarScreenState.currentindex,
          onTap: (value) {
            ref.read(bottomNavbarScreenProvider.notifier).onScreenChange(value);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.widgets_outlined), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            // BottomNavigationBarItem(
            //     // icon: IconButton(
            //     icon: Icon(Icons.notifications_none_outlined),
            //     // onPressed: () {
            //     //   Navigator.push(
            //     //       context,
            //     //       MaterialPageRoute(
            //     //           builder: (context) => NotificationScreen()));
            //     // },
            //     // ),
            //     label: "Notifications"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: "Account"),
          ]),
    );
  }
}
