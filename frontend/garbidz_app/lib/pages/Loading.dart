import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/components/User_model.dart';
import 'package:garbidz_app/pages/Home.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  void setupWorldTime() async{
   final data = await  DBProvider.db.getUser();
   if(data!=null){
     Home.isLogged = true;
   }
   await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, '/home');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
    setupWorldTime();

  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Garbidž",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
              ),
            ),
            SizedBox(height: 40),
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Image.asset("assets/icons/trash_loading.png",width: 180),
            ),
          ],
        ),
      ),
    );
  }
}
