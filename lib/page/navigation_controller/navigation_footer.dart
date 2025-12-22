import 'package:flutter/material.dart';
import 'package:altsome_app/page/home_page/home_page.dart';

class NavigationFooter extends StatefulWidget {
  const NavigationFooter({super.key});

  @override
  State<NavigationFooter> createState() => _NavigationFooterState();
}

class _NavigationFooterState extends State<NavigationFooter> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: const Color.fromARGB(255, 235, 234, 234),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.donut_small_rounded,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.donut_small_rounded,
              ),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.castle_rounded, color: Colors.blue),
              icon: Icon(Icons.castle_rounded),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bar_chart_sharp, color: Colors.blue),
              icon: Icon(Icons.bar_chart_sharp),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month, color: Colors.blue),
              icon: Badge(child: Icon(Icons.calendar_month)),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.window, color: Colors.blue),
              icon: Icon(Icons.window),
              label: '',
            ),
          ]),
      body: <Widget>[
        HomePage(),
        Placeholder(),
        Placeholder(),
        Placeholder()
      ][currentPageIndex],
    );
  }
}
