import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:garbidz_app/components/Container_model.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/components/User_model.dart';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/AdressGuide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbidz_app/pages/Home.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  PageController pageController = PageController(initialPage: 0);
  User newUser;

  Future<User> getDbData() async {
    final data = await DBProvider.db.getUser();
    User user = User.fromMap(data);
    return user;
  }

  Future getDbcontainer() async {
    final data = await DBProvider.db.getContainers();

    for (int i = 0; i < data.length; i++) {
      if (data[i]['type'] == 'zmesový komunálny odpad') {
        setState(() {
          _isSelectedButtons[0] = true;
        });
      } else if (data[i]['type'] == 'plasty') {
        setState(() {
          _isSelectedButtons[1] = true;
        });
      } else if (data[i]['type'] == 'papier a lepenka') {
        setState(() {
          _isSelectedButtons[2] = true;
        });
      } else {
        setState(() {
          _isSelectedButtons[3] = true;
        });
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getDbcontainer();
  }

  updateUser(String email) async {
    List positions = [];
    for (int i = 0; i < _isSelectedButtons.length; i++) {
      if (_isSelectedButtons[i]) {
        positions.add(i);
      }
    }
    for (int i = 0; i < positions.length; i++) {
      Kontainer container =
          Kontainer(type: _containerTypes[positions[i]], user_email: email);

      DBProvider.db.newContainer(container);
    }
  }

  int pageChange = 0;
  int idAddress = 0;
  String address = "";
  bool isAdress = false;
  var _isSelectedButtons = [false, false, false, false];
  var _containerTypes = [
    "zmesový komunálny odpad",
    "plasty",
    "papier a lepenka",
    "bioodpad"
  ];
  var _finishedGuide = false;
  Map _guideData = {};

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      if (pageChange > 0) {
        setState(() {
          print(index);
          _selectedIndex = 0;
          pageChange -= 1;
        });
        pageController.animateToPage(pageChange,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    } else {
      if (pageChange < 3) {
        setState(() {
          _selectedIndex = 1;
          pageChange++;
        });
        pageController.animateToPage(pageChange,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      ),
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: FutureBuilder(
          future: getDbData(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              AddressApi.token = user.token;
              return Center(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageChange = index;
                    });
                    print(pageChange);
                  },
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        color: Color.fromRGBO(63, 29, 90, 1.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "Nastavenia smetiakov",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 28.0,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10.0),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(28.0),
                                          topRight: Radius.circular(28.0))),
                                  child: Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Container(
                                                width: 150,
                                                child: Image.asset(
                                                    'assets/guide/03.png')),
                                          ),
                                          SizedBox(height: 20.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                                label: Text("Komunálny odpad"),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                  ),
                                                  primary: _isSelectedButtons[0]
                                                      ? Color.fromRGBO(
                                                          189, 18, 121, 0.3)
                                                      : Color.fromRGBO(
                                                          230, 230, 230, 0.5),
                                                  onPrimary: Color.fromRGBO(
                                                      63, 29, 90, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                icon: Icon(Icons.delete,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  setState(() {
                                                    _isSelectedButtons[0] =
                                                        !_isSelectedButtons[0];
                                                  });
                                                }),
                                          ),
                                          SizedBox(height: 19.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                                label: Text("Plasty"),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                  ),
                                                  primary: _isSelectedButtons[1]
                                                      ? Color.fromRGBO(
                                                          189, 18, 121, 0.3)
                                                      : Color.fromRGBO(
                                                          230, 230, 230, 0.5),
                                                  onPrimary: Color.fromRGBO(
                                                      63, 29, 90, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                icon: Icon(Icons.delete,
                                                    color: Color.fromRGBO(
                                                        241, 196, 15, 1.0)),
                                                onPressed: () {
                                                  setState(() {
                                                    _isSelectedButtons[1] =
                                                        !_isSelectedButtons[1];
                                                  });
                                                }),
                                          ),
                                          SizedBox(height: 19.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                                label: Text("Papier"),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                  ),
                                                  primary: _isSelectedButtons[2]
                                                      ? Color.fromRGBO(
                                                          189, 18, 121, 0.3)
                                                      : Color.fromRGBO(
                                                          230, 230, 230, 0.5),
                                                  onPrimary: Color.fromRGBO(
                                                      63, 29, 90, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                icon: Icon(Icons.delete,
                                                    color: Color.fromRGBO(
                                                        52, 152, 219, 1.0)),
                                                onPressed: () {
                                                  setState(() {
                                                    _isSelectedButtons[2] =
                                                        !_isSelectedButtons[2];
                                                  });
                                                }),
                                          ),
                                          SizedBox(height: 19.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                                label: Text("Bioodpad"),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.0,
                                                  ),
                                                  primary: _isSelectedButtons[3]
                                                      ? Color.fromRGBO(
                                                          189, 18, 121, 0.3)
                                                      : Color.fromRGBO(
                                                          230, 230, 230, 0.5),
                                                  onPrimary: Color.fromRGBO(
                                                      63, 29, 90, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                icon: Icon(Icons.delete,
                                                    color: Color.fromRGBO(
                                                        159, 97, 106, 1.0)),
                                                onPressed: () {
                                                  setState(() {
                                                    _isSelectedButtons[3] =
                                                        !_isSelectedButtons[3];
                                                  });
                                                }),
                                          ),
                                          SizedBox(height: 40.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                child: Text("Nastaviť"),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(8.0),
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                  ),
                                                  primary: Color.fromRGBO(
                                                      189, 18, 121, 1.0),
                                                  alignment: Alignment.center,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                onPressed: () async {
                                                  await DBProvider.db
                                                      .dropContainers();
                                                  await updateUser(user.email);

                                                  Navigator.pop(context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
