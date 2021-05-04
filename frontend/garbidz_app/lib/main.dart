import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbidz_app/components/Database.dart';
import 'package:garbidz_app/pages/Home.dart';
import 'package:garbidz_app/pages/Loading.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:garbidz_app/components/globals.dart' as globals;

import 'components/User_model.dart';
Workmanager workmanager = Workmanager();
Workmanager workmanager2 = Workmanager();

FlutterLocalNotificationsPlugin fltrNotification = new FlutterLocalNotificationsPlugin();
var androidInitilize = new AndroidInitializationSettings('ic_launcher');
var iOSinitilize = new IOSInitializationSettings();
var initilizationsSettings = new InitializationSettings(android: androidInitilize,
    iOS: iOSinitilize);


Future callbackDispatcher() async{
  workmanager.executeTask((task, inputData) async {
    /*Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ); /*//simpleTask will be emitted here.
    */
     */

    await workmanager2.registerPeriodicTask("4", "simpleTask",frequency: Duration(minutes: 15),
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresDeviceIdle: false,
            requiresStorageNotLow: false
        ));
    return Future.value(true);
  });
}

Future callbackDispatcher2() async{
  workmanager2.executeTask((task, inputData) async {
    /*Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ); /*//simpleTask will be emitted here.
    */
     */

      await _showNotification();

    return Future.value(true);
  });
}

Future notificationSelected(String payload) async{
}
Future _showNotification()async{
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  print(currentTimeZone);
  tz.initializeTimeZones();
  var androidDetails = new AndroidNotificationDetails("Channel ID", "Garbidž", "Garbidž notifikácia", importance: Importance.max);
  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iSODetails);
  var date = DateTime.now().add(Duration(seconds: 20)).millisecondsSinceEpoch;
  //var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20));
  var scheduledTime = tz.TZDateTime.parse(tz.getLocation("Europe/Budapest"), "2021-05-03 01:14:00");
  print(scheduledTime);
  await fltrNotification.show(
      1,
      "Odvoz ty kokot",
      "Hnijú ti smeti, bacha",
      generalNotificationDetails,
  payload: "Task");
  print(scheduledTime);
}
Future <void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  fltrNotification.initialize(initilizationsSettings, onSelectNotification: notificationSelected);
  workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  workmanager2.initialize(
      callbackDispatcher2, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  workmanager.registerPeriodicTask("2",
    "registerPeriodicTask",
    frequency: Duration(minutes: 30),
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


