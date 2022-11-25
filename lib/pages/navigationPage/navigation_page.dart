import 'package:flutter/material.dart';
import 'package:stryn_esport/pages/bookingPage/booking_page.dart';
import 'package:stryn_esport/pages/porfilePage/profile_page.dart';
import 'package:stryn_esport/widgets/persistent_tab.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    _pages =  [
      PersistantTab(
        child: ProfilePage(
          key: const PageStorageKey('profilePage'),
        ),
      ),
      const PersistantTab(
        child: BookingPage(key: PageStorageKey('BookingPage')),
      ),

    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
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
