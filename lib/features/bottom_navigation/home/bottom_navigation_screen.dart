
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  // List of widget options to display in each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen()
    // Text('Profile Screen', style: TextStyle(fontSize: 24)),
    // Text('Settings Screen', style: TextStyle(fontSize: 24)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Display the selected widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PathConstents.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PathConstents.category),
            label: '',
          ),
           BottomNavigationBarItem(
             icon: SvgPicture.asset(PathConstents.graph),
            label: '',
          ),
          BottomNavigationBarItem(
             icon: SvgPicture.asset(PathConstents.settingbottom),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          
        }, 
      ),
    );
  }
}