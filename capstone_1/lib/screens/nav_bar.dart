import 'package:capstone_1/screens/following_screen.dart';
import 'package:capstone_1/screens/home_screen.dart';
import 'package:capstone_1/screens/profile_screens/profile_screen.dart';
import 'package:capstone_1/screens/search_screen.dart';
import 'package:capstone_1/screens/chat_screen/users_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {


  List screensList = [
    const HomeScreen(),
    const TripListScreen(),
    SearchScreen(),
    const ProfileScreen(),
    const UsersScreen(),
  ];

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[selected],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: const Color(0xff023047),
        selectedIndex: selected,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          selected = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: const Icon(
              Icons.people,
              color: Colors.white,
            ),
            title: const Text('Trips'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: const Text('Search'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: const Text('Profile'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: const Icon(
              Icons.chat_bubble_outline_sharp,
              color: Colors.white,
            ),
            title: const Text('chat'),
          ),
        ],
      ),
    );
  }
}
