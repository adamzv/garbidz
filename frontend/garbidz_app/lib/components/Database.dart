import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:garbidz_app/components/User_model.dart';

class DBProvider{

  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {

    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "grb_data.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE users ("
            "first_name TEXT PRIMARY KEY,"
            "last_name TEXT,"
            "email TEXT,"
            "token TEXT"
            ")");

      },
    );
  }


  newUser(User newUser) async{
    final db = await database;
    String querry = "SELECT COUNT(email) FROM users WHERE email='"+ newUser.email+"'";

     int count = Sqflite.firstIntValue(await db.rawQuery(querry));
     if(count ==0){
    var res = await db.rawInsert('''
      INSERT INTO users(
       first_name, last_name, email, token) 
       VALUES(?,?,?,?)
    ''', [newUser.first_name, newUser.last_name, newUser.email, newUser.token]);

    return res;}
     else{
       var res = await db.rawUpdate('''
      UPDATE users SET
       first_name = ?, last_name = ?, email = ?, token = ?
       
      WHERE email = ?''', [newUser.first_name, newUser.last_name, newUser.email, newUser.token,newUser.email]);

       return res;}

     }



  Future<dynamic> getUser() async {
    final db = await database;

    var res = await db.query("users");
    if(res.length == 0){
      return null;
    }else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }


  }




}