import 'package:flutter/material.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/pages/SettingsContainer.dart';
import 'package:garbidz_app/pages/SettingsProfile.dart';

import 'Home.dart';
import 'SettingsTime.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future logout() async {
    await DBProvider.db.dropContainers();
    await DBProvider.db.dropUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Nastavenia",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 0.0,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsProfilePage(),
                            ));
                      },
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/icons/profile.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Profil",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContainerPage(),
                            ));
                      },
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/icons/garbage.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Kontajner",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Time(),
                            ));
                      },
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/icons/alarm.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Čas",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await logout();
                        Home.isLogged = false;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      },
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/logout.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Odhlásiť sa",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
