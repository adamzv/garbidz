import 'package:flutter/material.dart';
import 'package:garbidz_app/pages/Login.dart';
import 'dart:math' as math;

class Register extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  bool _isObscure = true;
  bool _isObscure2 = true;

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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              },
                              child: Text(
                                'Prihlásiť sa',
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Registrácia',
                                style: TextStyle(
                                    color: Color.fromRGBO(63, 29, 90, 1.0),
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600),
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
                                    "Zaregistrujte sa tu!",
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
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Meno',
                                    prefixIcon:
                                        Icon(Icons.account_circle_rounded),
                                    hintText: 'Vložte meno'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Priezvisko',
                                  hintText: 'Vložte priezvisko'),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Vložte email v tvare abc@abc.com'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                              hoverColor: Color.fromRGBO(63, 29, 90, 1.0),
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
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: _isObscure2,
                          decoration: InputDecoration(
                              hoverColor: Color.fromRGBO(63, 29, 90, 1.0),
                              border: UnderlineInputBorder(),
                              labelText: 'Zopakujte heslo',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure2 = !_isObscure2;
                                    });
                                  }),
                              hintText: 'Vložte heslo ešte raz'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 20, bottom: 0),
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(189, 18, 121, 1.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Zaregistrovať sa',
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
