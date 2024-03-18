import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/screens/add_screen.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/profile_screen.dart';
import 'package:social_app/screens/search_screen.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        children: const [
          HomeScreen(),
          AddScreen(),
          SearchScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        elevation: 0,
        onDestinationSelected: (value) {
          currentIndex = value;
          pageController.jumpToPage(currentIndex);
          setState(() {});
        },
        indicatorColor: kPrimaryColor.withOpacity(0.2),
        backgroundColor: kWhiteColor.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Add',
            icon: Icon(Icons.add_circle_outline),
          ),
          NavigationDestination(
            label: 'Search',
            icon: Icon(
              Icons.search_outlined,
            ),
          ),
          NavigationDestination(
            label: 'Profile',
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
