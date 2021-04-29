import 'package:flutter/material.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/pages/Home.dart';
import 'package:garbidz_app/pages/Loading.dart';

import 'components/User_model.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home':(context)=>Home()
    },
  ));
}


