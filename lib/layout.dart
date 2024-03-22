import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_colors.dart';
import 'package:social_app/providers/user_provider.dart';
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
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
              indicatorColor: kPinkColor,
              backgroundColor: kWhiteColor.withOpacity(0.2),
              surfaceTintColor: kPrimaryColor,
              destinations: [
                NavigationDestination(
                  label: 'Home',
                  icon: const Icon(Icons.home),
                  selectedIcon: Icon(
                    Icons.home,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  label: 'Add',
                  icon:const Icon(Icons.add_circle_outline),
                  selectedIcon: Icon(
                    Icons.add_circle_outline,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  label: 'Search',
                  icon: const Icon(
                    Icons.search_outlined,
                  ),
                  selectedIcon: Icon(
                    Icons.search_outlined,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  label: 'Profile',
                  icon:const Icon(Icons.person_outline),
                  selectedIcon: Icon(
                    Icons.person_outline,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          );
  }
}
