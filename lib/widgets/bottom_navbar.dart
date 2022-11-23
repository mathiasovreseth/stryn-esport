import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stryn_esport/pages/bookingPage/booking_page.dart';
import 'package:stryn_esport/pages/porfilePage/profile_page.dart';

import '../pages/homePage/home_page.dart';
import '../pages/settings/settings_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    debugPrint("$index");
    //TODO if current index = index move to top else
    switch (index) {
      case 0:
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(CustomPageRoute(builder: (context) => const ProfilePage()));
        });
        break;
      case 1:
        Navigator.of(context).pushReplacement(CustomPageRoute(builder: (context) => BookingPage()));
        break;

      case 2: break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      selectedItemColor:  const Color.fromRGBO(24, 144, 255, 1),
      unselectedItemColor: Colors.black,
      backgroundColor: const Color(0xfff3f3f3),
      onTap: _onItemTapped,
    );
  }
}
class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}


