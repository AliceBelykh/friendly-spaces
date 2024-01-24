import 'package:flutter/material.dart';
import 'package:friendly_spaces/pages/space_page.dart';
import 'package:friendly_spaces/pages/home_page.dart';
import 'package:friendly_spaces/pages/profile_page.dart';
import 'package:friendly_spaces/my_components/my_navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int pageIndex = 1;

  void changeTab(int index){
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: IndexedStack(
          index: pageIndex,
          children: [
            SpacePage(),
            HomePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(onTabChange: changeTab),
    );
  }
}
