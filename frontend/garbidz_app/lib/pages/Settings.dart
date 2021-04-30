import 'dart:convert';
import 'dart:math' as math;
import 'package:garbidz_app/components/globals.dart' as globals;
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


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PageController pageController = PageController(initialPage: 0);
  User newUser;
  bool _isObscure = true;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<User> getDbData() async {
    final data = await DBProvider.db.getUser();
    User user = User.fromMap(data);
    return user;
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

  final TextEditingController _typeAheadController = TextEditingController();

  TimeOfDay time;
  TimeOfDay picked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = TimeOfDay.now();
  }




  Future Change(User user, String password) async {
    String uri = "10.0.2.2:8080";

    final response = await http.put(
      Uri.http(globals.uri, "/api/users/"+user.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'name': user.first_name,
        'surname': user.last_name,


      }),
    );

    if (response.statusCode == 200) {

    } else {
      print(response.body);


    }
  }





  Future<void> _sendFinishedGuide(
      Map json, BuildContext context, String email, String token) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8080/api/auth/finish');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(json));
      if (response.statusCode == 200) {
        List positions = [];
        for (int i = 0; i < _isSelectedButtons.length; i++) {
          if (_isSelectedButtons[i]) {
            positions.add(i);
          }
        }
        for (int i = 0; i < positions.length; i++) {
          Kontainer container =
              Kontainer(type: _containerTypes[i], user_email: email);
          DBProvider.db.newContainer(container);
        }

        DBProvider.db.newTime(
            email, (time.hour).toString() + ":" + (time.minute).toString());
        print(response.body);
        Home.isLogged = true;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        print(response.body);
        print("fok");
      }
      print(json);
    } catch (e) {
      print(e);
    }
  }

  void _finishGuide() {
    if (idAddress > 0) {
      List positions = [];
      for (int i = 0; i < _isSelectedButtons.length; i++) {
        if (_isSelectedButtons[i]) {
          positions.add(i);
        }
      }
      if (positions.length > 0) {
        Map json = {
          'addressId': idAddress,
          'containers': List.from(positions.map((e) => {
                'addressId': idAddress,
                'garbageType': _containerTypes[e]
              })).toList()
        };
        setState(() {
          _guideData = json;
          _finishedGuide = true;
        });
      } else {
        setState(() {
          _finishedGuide = false;
        });
      }
    } else {}
  }

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

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: FutureBuilder(
          future: getDbData(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              AddressApi.token = user.token;
              _controllerName.text = user.first_name;
              _controllerSurname.text = user.last_name;
              _typeAheadController.text = user.address;
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
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(63, 29, 90, 1.0),
                            Color.fromRGBO(63, 29, 90, 1.0),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                        )),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child:
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      child: Transform(
                                        transform: Matrix4.rotationY(math.pi),
                                        alignment: Alignment.center,
                                        child: Transform.rotate(
                                          angle: -0.20,
                                          child: Center(
                                            child: Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                    'assets/icons/trash.png')),
                                          ),
                                        ),
                                      ),
                                    ),

            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0, bottom: 0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    )),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                        padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                            top: 30,
                                            bottom: 30),
                                        child: Stack(
                                          children: <Widget>[
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Osobné nastavenia",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          63, 29, 90, 1.0),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 0,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _controllerName,
                                              decoration: InputDecoration(
                                                  errorStyle:
                                                      TextStyle(height: 0),
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Meno',
                                                  prefixIcon: Icon(Icons
                                                      .account_circle_rounded),
                                                  hintText: 'Vložte meno'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: TextField(
                                            controller: _controllerSurname,
                                            decoration: InputDecoration(
                                                errorStyle:
                                                    TextStyle(height: 0),
                                                border: UnderlineInputBorder(),
                                                labelText: user.last_name,
                                                hintText: 'Vložte priezvisko'),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 0,
                                          bottom: 10),
                                      //padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: TextField(
                                        obscureText: _isObscure,
                                        controller: _controllerPassword,
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            hoverColor:
                                                Color.fromRGBO(63, 29, 90, 1.0),
                                            border: UnderlineInputBorder(),
                                            labelText: 'Heslo',
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                                icon: Icon(_isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                }),
                                            hintText: 'Vložte heslo'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 0,
                                          bottom: 10),
                                      child: TypeAheadField<AdressGuide>(
                                        debounceDuration:
                                            Duration(milliseconds: 400),
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                                autofocus: false,
                                                controller: _typeAheadController,
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style
                                                        .copyWith(
                                                          decoration:
                                                              TextDecoration.none,
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                decoration: InputDecoration(
                                                  suffixIcon: Icon(Icons.add_location),
                                                    hintText:
                                                        "Nájdite svoju lokalitu...")),
                                        suggestionsCallback:
                                            AddressApi.getAddressSuggestions,
                                        itemBuilder:
                                            (context, AdressGuide suggestion) {
                                          final address = suggestion;
                                          return ListTile(
                                            leading: Icon(Icons.location_pin),
                                            title: Text(address.name),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          _typeAheadController.text =
                                              suggestion.name;
                                          setState(() {
                                            idAddress = suggestion.id;
                                            address = suggestion.name;
                                            isAdress = true;
                                            _finishGuide();
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 20,
                                          bottom: 0),
                                      child: Container(
                                        height: 50,
                                        width: 350,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                189, 18, 121, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextButton(
                                          onPressed: () async {

                                          },
                                          child: Text(
                                            'Zmena údajov',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
