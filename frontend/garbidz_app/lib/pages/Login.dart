import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garbidz_app/components/Container_model.dart';
import 'package:garbidz_app/components/User_model.dart';
import 'package:garbidz_app/pages/Register.dart';
import 'package:garbidz_app/pages/Guide.dart';
import 'package:garbidz_app/pages/Home.dart';
import 'package:garbidz_app/components/Database.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:garbidz_app/components/globals.dart' as globals;







class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  int _address = 3;



  Future login(String password, String username) async {
    String uri = "10.0.2.2:8080";
    String address = null;
    final response = await http.post(
      Uri.http(globals.uri, "/api/auth/signin"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      DBProvider.db.dropContainers();
      DBProvider.db.dropUsers();
      globals.token = jsonDecode(response.body)['token']['token'];
      globals.idUser = jsonDecode(response.body)['id'].toString();
      if( jsonDecode(response.body)['address']== null){
            _address = 0;


           if((jsonDecode(response.body)['containerUser']).length != 0){

           }
      }else{
        address = jsonDecode(response.body)['address']['address'];
          for(int i =0; i<(jsonDecode(response.body)['containerUser']).length; i++){
            Kontainer container = Kontainer(type:(jsonDecode(response.body)['containerUser'][i]['container']['garbageType']), user_email: (jsonDecode(response.body)['email']));
            await DBProvider.db.newContainer(container);


    }
      }


      var newUser = User(id: jsonDecode(response.body)['id'], first_name: jsonDecode(response.body)['name'], last_name: jsonDecode(response.body)['surname'], email: jsonDecode(response.body)['email'], token: jsonDecode(response.body)['token']['token'], address: address );
      await DBProvider.db.newUser(newUser);
    } else {
      print(response.body);
      _address = 1;

    }
  }


  final TextEditingController _controller = TextEditingController();

  final TextEditingController _controller2 = TextEditingController();
  Future _futurelogin;

  bool isEmailValidate = false;
  bool isPassValidate = false;

  bool validate(String email, String pass){
    if(email.isEmpty){
      setState(() {
        isEmailValidate = true;
      });

      return false;
    }
    else if(pass.isEmpty){
      isEmailValidate = false;
      setState(() {
        isPassValidate = true;
      });
      return false;
    }
    isPassValidate = false;
    return true;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 15.0, top: 0, bottom: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "GARBID??",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 10, top: 0, bottom: 0),
                        child: Transform(
                          transform: Matrix4.rotationY(math.pi),
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -0.20,
                            child: Center(
                              child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('assets/icons/trash.png')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
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
                      Container(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Prihl??si?? sa',
                                style: TextStyle(
                                    color: Color.fromRGBO(63, 29, 90, 1.0),
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                              },
                              child: Text(
                                'Registr??cia',
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10, bottom: 0),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "VITAJTE!",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(63, 29, 90, 1.0),
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                              errorText: isEmailValidate ? 'Pros??m vlo??te email': null,
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              hintText: 'Vlo??te email v tvare abc@abc.com'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: _isObscure,
                          controller: _controller2,
                          decoration: InputDecoration(
                              hoverColor: Color.fromRGBO(63, 29, 90, 1.0),
                              errorText: isPassValidate ? 'Pros??m vlo??te heslo': null,
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
                              hintText: 'Vlo??te heslo'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(189, 18, 121, 1.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () async {
                              if(validate(_controller.text,_controller2.text)) {

                                await login(_controller2.text,_controller.text);

                              if(_address == 0) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Guide(),
                                    ));



                              }else if(_address ==1){
                                final snackBar = SnackBar(
                                    content: Text('Zl?? prihlasovacie meno alebo heslo!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              }else {
                                Home.isLogged = true;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ));
                              }



                              }

                              },
                            child: Text(
                              'Prihl??si?? sa',
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
    );
  }
}
