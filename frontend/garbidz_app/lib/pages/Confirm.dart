import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math' as math;
import 'dart:convert';
import 'package:garbidz_app/pages/Login.dart';
import 'package:garbidz_app/components/globals.dart' as globals;




Future ConfirmRequest(String token) async {
  String uri = "10.0.2.2:8080";
  final response = await http.get(
    Uri.http(globals.uri, "/api/auth/confirm",{'token': token}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
   );


  if (response.statusCode == 200) {
    return true;
  }

  else {

   return false;

  }

}













class Confirm extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<Confirm> {

  final TextEditingController _controllertoken= TextEditingController();

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
                          "GARBIDŽ",
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

                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10, bottom: 0),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "ZADAJTE POTVRDZOVACÍ KÓD!",
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
                          controller: _controllertoken,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Kód',

                              hintText: 'Vložte kód'),
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
                                  if(await ConfirmRequest(_controllertoken.text)) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
                                  }else{

                                    final snackBar = SnackBar(
                                        content: Text('Niekde nastala chyba.'));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar);
                                  }
                            },
                            child: Text(
                              'Odoslať',
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

