import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:garbidz_app/components/Container_model.dart';
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
            "id INTEGER,"
            "first_name TEXT,"
            "last_name TEXT,"
            "email TEXT PRIMARY KEY,"
            "token TEXT,"
            "address TEXT NULL,"
            "time TEXT NULL"
            ")");
        await db.execute("CREATE TABLE containers ("
            "id INTEGER PRIMARY KEY,"
            "type TEXT,"
            "user_email TEXT,"
            "FOREIGN KEY (user_email) REFERENCES Users (email) ON DELETE NO ACTION ON UPDATE NO ACTION"
            ")");

      },
    );
  }

  newTime(String email,String time) async {
    final db = await database;
    var res = await db.rawUpdate('''
      UPDATE users SET
        time = ?
       
      WHERE email = ?''', [time, email]);

    return res;
  }

  newAddress(String email,String address) async {
    final db = await database;
    var res = await db.rawUpdate('''
      UPDATE users SET
        address = ?
       
      WHERE email = ?''', [address, email]);

    return res;
  }

  newUser(User newUser) async{
    final db = await database;
    String querry = "SELECT COUNT(email) FROM users WHERE email='"+ newUser.email+"'";

     int count = Sqflite.firstIntValue(await db.rawQuery(querry));
     if(count ==0){
    var res = await db.rawInsert('''
      INSERT INTO users(
       id, first_name, last_name, email, token, address, time) 
       VALUES(?,?,?,?,?,?,?)
    ''', [newUser.id, newUser.first_name, newUser.last_name, newUser.email, newUser.token,newUser.address, newUser.time]);

    return res;}
     else{
       var res = await db.rawUpdate('''
      UPDATE users SET
       id = ?, first_name = ?, last_name = ?, email = ?, token = ?, address = ?, time = ?
       
      WHERE email = ?''', [newUser.id,newUser.first_name, newUser.last_name, newUser.email, newUser.token,newUser.address,newUser.time, newUser.email]);

       return res;}

     }



  dropUsers() async{
    final db = await database;

    var res = await db.delete('users');
    var res2 = await db.delete('containers');

    return res;


  }

  dropContainers() async{
    final db = await database;


    var res = await db.delete('containers');

    return res;


  }



  newContainer(Kontainer newContainer) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM containers");
    int id = table.first["id"];
    var res = await db.rawInsert('''
      INSERT INTO containers(
       id, type, user_email) 
       VALUES(?,?,?)
    ''', [id,newContainer.type, newContainer.user_email]);

      return res;


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
// TODO: return containers
  Future<dynamic> getContainers(String email) async {
    final db = await database;

    var res = await db.rawQuery("SELECT * FROM containers WHERE email ="+ email);
    if(res.length == 0){
      return null;
    }else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }


  }



}