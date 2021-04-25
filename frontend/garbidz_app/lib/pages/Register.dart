import 'package:flutter/material.dart';
import 'package:garbidz_app/pages/Login.dart';
import 'package:garbidz_app/pages/Confirm.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future RegisterRequest(String password, String username, String email, String surname) async {
  String uri = "10.0.2.2:8080";
  final response = await http.post(
    Uri.http(uri, "/api/auth/signup"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'name': username,
      'password': password,
      'surname': surname,
    }),
  );

  if (response.statusCode == 200) {
     print("we got this");
    }

   else {

    final  snackBar = SnackBar(
        content: Text('Vyplňte všetky polia !'));
   return snackBar;

  }

}





class Register extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _validate = false;
  bool _validatepass = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();


  bool validate(String name, String surname, String email, String password, String password2 ){

    if(name.isEmpty ||surname.isEmpty||email.isEmpty||password.isEmpty||password2.isEmpty){
       setState(() {
         _validate = true;
       });
       return false;
    }
    setState(() {
      _validate = false;
    });
      return true;
  }

  bool passwordConfirm(String password, String password2){
    if(password == password2){
     setState(() {
       _validatepass =false;
     });
      return true;

    }setState(() {
      _validatepass =true;
    });
    return false;
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
                            left: 15.0, right: 15.0, top: 0, bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controllerName,
                                decoration: InputDecoration(
                                    errorText: _validate ? '': null,
                                    errorStyle: TextStyle(height: 0),
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
                                  controller: _controllerSurname,
                              decoration: InputDecoration(
                                  errorText: _validate ? '': null,
                                  errorStyle: TextStyle(height: 0),
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
                            left: 15.0, right: 15.0, top: 0, bottom: 0),
                        child: TextField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                              errorText: _validate ? '': null,
                              errorStyle: TextStyle(height: 0),
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Vložte email v tvare abc@abc.com'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 0, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: _isObscure,
                          controller: _controllerPassword,
                          decoration: InputDecoration(
                              errorText: _validate ? '': null,
                              errorStyle: TextStyle(height: 0),
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
                            left: 15.0, right: 15.0, top: 0, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: _isObscure2,
                          controller: _controllerPassword2,
                          decoration: InputDecoration(
                              errorText: _validate ? '': null,
                              errorStyle: TextStyle(height: 0),
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
                            onPressed: () async {
                              if(validate(_controllerPassword.text,
                                  _controllerName.text,
                                  _controllerEmail.text,
                                  _controllerSurname.text,
                              _controllerPassword2.text)){
                                if(passwordConfirm(_controllerPassword.text, _controllerPassword2.text)) {
                                  await RegisterRequest(_controllerPassword.text, _controllerName.text, _controllerEmail.text, _controllerSurname.text);


                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Confirm(),
                                        ));

                                }else {
                                  final snackBar = SnackBar(
                                      content: Text('Heslá sa nezhodujú!'));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar);
                                }
                              }else{
                              final snackBar = SnackBar(
                                  content: Text('Vyplňte všetky polia !'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);}

                            },
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
