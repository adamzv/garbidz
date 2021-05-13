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
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'components/User_model.dart';

Workmanager workmanager = Workmanager();

FlutterLocalNotificationsPlugin fltrNotification = new FlutterLocalNotificationsPlugin();
var androidInitilize = new AndroidInitializationSettings('ic_launcher');
var iOSinitilize = new IOSInitializationSettings();
var initilizationsSettings = new InitializationSettings(android: androidInitilize,
    iOS: iOSinitilize);


Future callbackDispatcher() async{
  workmanager.executeTask((task, inputData) async {
    final data = await  DBProvider.db.getUser();
    if(data!=null) {
      User user = User.fromMap(data);
      if(user.address != null){
        await getNotification(user.id, user.time);
      }
    }

    return Future.value(true);
  });
}

Future <void> getNotification(int id, String est) async{
  print("toto je čas z sql local" + est);
  var estimate = est;
  var now = DateTime.now().millisecondsSinceEpoch.toString();
  var nowDate = DateTime.now().toString();
  var estimateDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(nowDate)).toString() +" "+ estimate;
  var estimateParsed = DateTime.parse(estimateDate).millisecondsSinceEpoch.toString();

  var lastNotification = int.parse(now) - 900000;
  if((int.parse(estimateParsed) < int.parse(now)) && int.parse(estimateParsed) >= lastNotification){
    print("TU JE NOTIFIKACIA");
    final url = Uri.parse('http://'+globals.uri+'/api/schedules/user/'+id.toString());
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8'
        });
    if(response.statusCode == 200) {
      List decoded  = jsonDecode(response.body)['content'];
      var tommorow = DateFormat('dd.MM.yyyy').format(DateTime.now().add(const Duration(days: 1)));
      var firstRemoval = DateFormat('dd.MM.yyyy').format(DateTime.parse(decoded[0]['schedule']['datetime']));
      print(firstRemoval);
      if(firstRemoval == "17.05.2021") {
        List containers =[];
        for (int i = 0; i < 10; i++) {
          if(DateFormat('dd.MM.yyyy').format(DateTime.parse(decoded[i]['schedule']['datetime'])) == "17.05.2021"){
            containers.add(decoded[i]['container']['garbageType']);
          }else{
            break;
          }
        }
        _showNotification(firstRemoval, containers);
      }
    }

    }
}

Future notificationSelected(String payload) async{
}
Future _showNotification(String dateRemoval, List type)async{
  var androidDetails = new AndroidNotificationDetails("Channel ID", "Garbidž", "Garbidž notifikácia",
      importance: Importance.max, styleInformation: BigTextStyleInformation(""));

  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iSODetails);
  String types = "";
  for(int i = 0; i<type.length; i++){
    types += "\n"+type[i];
  }
  await fltrNotification.show(
      1,
      "Odvoz smetí - " + dateRemoval,
      "Zajtra Vás čaká odvoz : " + types,
      generalNotificationDetails,
  payload: "Task");
}

Future <void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  fltrNotification.initialize(initilizationsSettings, onSelectNotification: notificationSelected);
  workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
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
  //await getDates();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home':(context)=>Home()
    },
  ));
}


