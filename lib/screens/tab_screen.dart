import 'package:flutter/material.dart';

import 'landing_screen.dart';
import 'about_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int selectedIndex = 0;

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': const LandingScreen(), 'title': "Chat App"},
      {'page': const About(), 'title': "About Us"}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectedPage,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sms,
                  color: Colors.blue,
                ),
                label: "Send Message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                label: "About Us"),
          ]),
    );
  }
}
