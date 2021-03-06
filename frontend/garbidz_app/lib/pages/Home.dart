import 'package:flutter/material.dart';
import 'package:garbidz_app/pages/Login.dart';
import 'package:garbidz_app/pages/MapContainers.dart';
import 'package:garbidz_app/pages/Removals.dart';
import 'package:garbidz_app/pages/Settings.dart';
import 'package:garbidz_app/components/globals.dart' as globals;

class Home extends StatefulWidget {
  static bool isLogged = false;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     List<Widget> _notLogged = <Widget>[
      MapContainers(),
      Login(),
    ];

     List<Widget> _logged = <Widget>[
      Removals(),
      MapContainers(),
      SettingsPage(),
    ];

    List<BottomNavigationBarItem> itemsLogged = [
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
      )
    ];
     List<BottomNavigationBarItem> itemsNotLogged = [
         BottomNavigationBarItem(
           icon: Icon(Icons.location_pin),
           label: 'Mapa kontajnerov',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.account_circle),
           label: 'Účet',
         )
       ];


    List _items = Home.isLogged ? itemsLogged : itemsNotLogged;

    return Scaffold(
        body: Home.isLogged ? _logged[_selectedIndex] : _notLogged[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(255, 255, 255, 1.0)),
          selectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 255, 255, 1.0)),
          unselectedIconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 0.6)),
          selectedIconTheme:  IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
          unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.6),
          backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(255, 255, 255, 1),
          onTap: _onItemTapped,
        )
    );
  }
}
