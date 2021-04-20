import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/AdressGuide.dart';
import 'package:garbidz_app/components/AdressGuide.dart';
import 'dart:convert';

class Guide extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<Guide> {
  PageController pageController = PageController(initialPage: 0);
  int pageChange = 0;
  int idAddress = 0;
  var _isSelectedButtons = [false, false, false, false];

  final TextEditingController _typeAheadController = TextEditingController();

  TimeOfDay time;
  TimeOfDay picked;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = TimeOfDay.now();
  }
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if(index == 0){
      if(pageChange>0) {
        setState(() {
          print(index);
          _selectedIndex = 0;
          pageChange -= 1;
        });
        pageController.animateToPage(pageChange, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    }else{
      if(pageChange<3){
        setState(() {
          _selectedIndex = 1;
          pageChange++;
        });
        pageController.animateToPage(pageChange, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    }
  }


  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(context: context, initialTime: time,builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child,
      );
    },);
    if(picked != null){
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (index){
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
                    SizedBox(height: 40.0),
                    Text(
                      "Nastavte sa",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Expanded(
                      flex: 1,
                        child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Image.asset('assets/guide/01.png'),
                            SizedBox(height: 20.0),
                            Text("Dobrý deň,",
                            style: TextStyle(
                              color: Color.fromRGBO(63, 29, 90, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0,
                              ),
                            ),
                            Text("Juraj",
                              style: TextStyle(
                                color: Color.fromRGBO(63, 29, 90, 1.0),
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text("Poďme na to!",
                              style: TextStyle(
                                color: Color.fromRGBO(63, 29, 90, 1.0),
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              color: Color.fromRGBO(63, 29, 90, 1.0),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Nastavte sa",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                               Center(
                                child: Container(
                                    width: 200,
                                    child: Image.asset('assets/guide/02.png')),
                              ),
                              SizedBox(height: 20.0),
                              Text("Začnime s výberom Vašej adresy",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Material(
                                child: TypeAheadField<AdressGuide>(
                                  debounceDuration: Duration(milliseconds: 400),
                                  textFieldConfiguration: TextFieldConfiguration(
                                    autofocus: false,
                                    controller: _typeAheadController,
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Nájdite svoju lokalitu..."
                                    )
                                  ),
                                  suggestionsCallback: AddressApi.getAddressSuggestions,
                                  itemBuilder: (context, AdressGuide suggestion) {
                                    final address = suggestion;
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        leading: Icon(Icons.location_pin),
                                        title: Text(address.name),
                                      ),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    _typeAheadController.text = suggestion.name;
                                    setState(() {
                                      idAddress = suggestion.id;
                                    });
                                    print(idAddress.toString());
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                color: Color.fromRGBO(63, 29, 90, 1.0),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      "Nastavte sa",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 28.0,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                          child: Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                        width: 200,
                                        child: Image.asset('assets/guide/03.png')),
                                  ),

                                  SizedBox(height: 20.0),
                                  Text("Pokračujeme výberom smetiakov, ktoré si želáte sledovať",
                                    style: TextStyle(
                                      color: Color.fromRGBO(63, 29, 90, 1.0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 30.0),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      label: Text("Komunálny odpad"),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(8.0),
                                        ),
                                        textStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                        ),
                                        primary: _isSelectedButtons[0] ? Color.fromRGBO(189, 18, 121, 0.3) : Color.fromRGBO(230, 230, 230, 0.5),
                                        onPrimary: Color.fromRGBO(63, 29, 90, 1.0),
                                        alignment: Alignment.centerLeft,
                                        elevation: 0,

                                        padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                      ),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.black
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          _isSelectedButtons[0] = !_isSelectedButtons[0];
                                        });
                                      }
                                    ),
                                  ),
                                  SizedBox(height: 19.0),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        label: Text("Plasty"),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                          ),
                                          textStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                          ),
                                          primary: _isSelectedButtons[1] ? Color.fromRGBO(189, 18, 121, 0.3) : Color.fromRGBO(230, 230, 230, 0.5),
                                          onPrimary: Color.fromRGBO(63, 29, 90, 1.0),
                                          alignment: Alignment.centerLeft,
                                          elevation: 0,

                                          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                        ),
                                        icon: Icon(
                                            Icons.delete,
                                            color: Color.fromRGBO(241, 196, 15, 1.0)
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _isSelectedButtons[1] = !_isSelectedButtons[1];
                                          });
                                        }
                                    ),
                                  ),
                                  SizedBox(height: 19.0),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        label: Text("Papier"),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                          ),
                                          textStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                          ),
                                          primary: _isSelectedButtons[2] ? Color.fromRGBO(189, 18, 121, 0.3) : Color.fromRGBO(230, 230, 230, 0.5),
                                          onPrimary: Color.fromRGBO(63, 29, 90, 1.0),
                                          alignment: Alignment.centerLeft,
                                          elevation: 0,

                                          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                        ),
                                        icon: Icon(
                                            Icons.delete,
                                            color: Color.fromRGBO(52, 152, 219, 1.0)
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _isSelectedButtons[2] = !_isSelectedButtons[2];
                                          });
                                        }
                                    ),
                                  ),
                                  SizedBox(height: 19.0),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        label: Text("Bioodpad"),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                          ),
                                          textStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                          ),
                                          primary: _isSelectedButtons[3] ? Color.fromRGBO(189, 18, 121, 0.3) : Color.fromRGBO(230, 230, 230, 0.5),
                                          onPrimary: Color.fromRGBO(63, 29, 90, 1.0),
                                          alignment: Alignment.centerLeft,
                                          elevation: 0,

                                          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                        ),
                                        icon: Icon(
                                            Icons.delete,
                                            color: Color.fromRGBO(159, 97, 106, 1.0)
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _isSelectedButtons[3] = !_isSelectedButtons[3];
                                          });
                                        }
                                    ),
                                  ),
                                  SizedBox(height: 40.0),
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              color: Color.fromRGBO(63, 29, 90, 1.0),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Nastavte sa",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                    width: 200,
                                    child: Image.asset('assets/guide/04.png')),
                              ),
                              SizedBox(height: 20.0),
                              Text("Deň dopredu Vám pošleme oznámenie, kedy si ho prajete dostať?",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                    label: Text("Vybratý čas - ${time.hour}:${time.minute}"),
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(8.0),
                                      ),
                                      textStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                      ),
                                      primary: Color.fromRGBO(189, 18, 121, 1.0),
                                      onPrimary: Colors.white,
                                      alignment: Alignment.center,
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                    ),
                                    icon: Icon(
                                        Icons.access_time,
                                        color: Colors.white
                                    ),
                                    onPressed: (){
                                      selectTime(context);
                                    }
                                ),
                              ),
                              SizedBox(height: 30.0)
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "" ,
            icon: Icon(Icons.arrow_back),
          ),
          BottomNavigationBarItem(
            label: "" ,
            icon: Icon(Icons.arrow_forward),
          ),
        ],
        onTap: _onItemTapped,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
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
        unselectedIconTheme: IconThemeData(color: Color.fromRGBO(63, 29, 90, 1.0),),
        selectedIconTheme:  IconThemeData(color: Color.fromRGBO(63, 29, 90, 1.0),),
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.6),
        selectedItemColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
