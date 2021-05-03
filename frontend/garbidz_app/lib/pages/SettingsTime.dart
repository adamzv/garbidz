import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:garbidz_app/components/Container_model.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/components/User_model.dart';
import 'package:garbidz_app/pages/Settings.dart';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/AdressGuide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbidz_app/pages/Home.dart';
class Time extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<Time> {
  PageController pageController = PageController(initialPage: 0);
  User newUser;

  Future<User>getDbData() async{
    final data = await DBProvider.db.getUser();
    User user = User.fromMap(data);

    return user;
  }

  int pageChange = 0;
  int idAddress = 0;
  String address = "";
  bool isAdress = false;

  TimeOfDay time;
  TimeOfDay picked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = TimeOfDay.now();

  }


  timeset(email) async{
    DBProvider.db.newTime(email, (time.hour).toString()+":"+(time.minute).toString());
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
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(63, 29, 90, 1.0),
      ),
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: FutureBuilder(
          future: getDbData(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot){
            if(snapshot.hasData){
              User user = snapshot.data;
              AddressApi.token = user.token;

              return Center(
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
                              "Nastavenie času",
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
                                              width: 150,
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
                                        SizedBox(height: 20.0),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              child: Text("Nastaviť"),
                                              style: ElevatedButton.styleFrom(
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(8.0),
                                                ),
                                                textStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18.0,
                                                ),
                                                primary:  Color.fromRGBO(189, 18, 121, 1.0),

                                                alignment: Alignment.center,
                                                elevation: 0,

                                                padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 15.0),
                                              ),
                                              onPressed: () async {
                                                await timeset(user.email);
                                                Navigator.pop(context);
                                              }
                                          ),
                                        ),

                                        SizedBox(height: 30.0),
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
              );
            }else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),

    );
  }
}
