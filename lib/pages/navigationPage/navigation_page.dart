import 'package:flutter/material.dart';
import 'package:stryn_esport/pages/becomeMemberPage/become_member_page.dart';
import 'package:stryn_esport/pages/bookingPage/booking_page.dart';
import 'package:stryn_esport/pages/porfilePage/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const ProfilePage(),
    const BecomeMemberPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Butikk',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(24, 144, 255, 1),
        unselectedItemColor: Colors.black,
        backgroundColor: const Color(0xfff3f3f3),
        onTap: _onItemTapped,
      ),
    );
  }
}
