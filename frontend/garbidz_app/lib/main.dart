import 'package:flutter/material.dart';
import 'package:garbidz_app/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}