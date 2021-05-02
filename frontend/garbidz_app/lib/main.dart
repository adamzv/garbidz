import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/pages/Home.dart';
import 'package:garbidz_app/pages/Loading.dart';
import 'package:workmanager/workmanager.dart';

import 'components/User_model.dart';
Workmanager workmanager = Workmanager();
void callbackDispatcher() {
  workmanager.executeTask((task, inputData) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  workmanager.registerPeriodicTask("2",
    "registerPeriodicTask",
    frequency: Duration(minutes: 15),
      constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false
      )
  ); //Android only (see below)

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home':(context)=>Home()
    },
  ));
}


