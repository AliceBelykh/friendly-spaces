import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavigationBar extends StatelessWidget{
  final Function(int) onTabChange;

  const MyNavigationBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: GNav(
          tabBorderRadius: 15,
          duration: Duration(milliseconds: 300),
          gap: 8,
          //iconSize: 24,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.primaryContainer,
          activeColor: Theme.of(context).colorScheme.primary,
          tabBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          selectedIndex: 1,
          // navigation bar padding
          tabs: const [
            GButton(
              icon: Icons.group,
              text: 'Space',
            ),
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          onTabChange: (index) => onTabChange(index),
        ),
      ),
    );
  }

}