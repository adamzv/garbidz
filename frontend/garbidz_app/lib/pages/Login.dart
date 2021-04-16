import 'package:flutter/material.dart';
import 'package:garbidz_app/pages/Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery
                .of(context)
                .size
                .height,
            maxWidth: MediaQuery
                .of(context)
                .size
                .width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(63, 29, 90, 1.0),
                  Color.fromRGBO(63, 29, 90, 1.0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,


              )
          ),


          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("GARBIDŽ", style: TextStyle(color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                      ),
                ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 10, top: 0, bottom: 0),
                       child: Center(

                          child: Container(
                              width: 100,
                              height:150,

                              child: Image.asset('assets/icons/trash.png')),
                        ),
                       ),
                    ],
                  ),

                ),
              ),
              Expanded(

                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )

                  ),
                  child: Column(

                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                         children:[
                           Container(

                          height: 30,
                          width: 220,

                              child: Row(
                                children: [
                                  FlatButton(

                                    onPressed: () {
                                    },
                                    child: Text(
                                      'Prihlásiť sa',
                                      style: TextStyle(
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600 ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),)
                                      );

                                    },
                                    child: Text(
                                      'TEST',
                                      style: TextStyle(
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                           ),
                                    ),
                                  ),

                                ],
                              )



                        ),
                        ]
                        ),
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 0),
                          child: Stack(
                    children: <Widget>[

                            Align(
                              alignment: Alignment.centerLeft,

                              child: Text(
                                "VITAJTE!",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Color.fromRGBO(63, 29, 90, 1.0),
                                   fontFamily: 'Poppins',
                                   fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                          )
                      )
                    ],
                  )

                        ),


                   Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      hintText: 'Enter valid email id as abc@gmail.com'),
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
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      hintText: 'Enter secure password'),
                  ),
                  ),
                    FlatButton(

                    onPressed: (){
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                      child: Stack(
                      children: <Widget>[

                        Align(
                        alignment: Alignment.centerLeft,
                          child: Text(
                          'Zabudnuté heslo ?',
                          style: TextStyle(
                            color: Color.fromRGBO(63, 29, 90, 1.0),
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),

                        ),
                      )
                    ],
                  ),

                  ),
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                      color: Color.fromRGBO(189, 18, 121, 1.0), borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                      onPressed: () {
                      },
                        child: Text(
                        'Prihlásiť sa',
                          style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600 ),
                      ),
                    ),
                  ),
                    SizedBox(
                     height: 130,
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