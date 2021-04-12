import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontFamily: 'Poppins', fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Odvozy',
      style: optionStyle,
    ),
    Text(
      'Mapy kontajnerov',
      style: optionStyle,
    ),
    Text(
      'Nastavenia',
      style: optionStyle,
    ),
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
        child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Odvozy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Mapa kontajnerov',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Nastavenia',
          ),
        ],
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(255, 255, 255, 1.0)
        ),
        selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 255, 255, 1.0)
        ),
        unselectedIconTheme: IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 0.6)
        ),
        selectedIconTheme: IconThemeData(
            color: Color.fromRGBO(255, 255, 255, 1.0)
        ),
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.6),
        backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(255, 255, 255, 1),
        onTap: _onItemTapped,

      ),
    );
  }
}

