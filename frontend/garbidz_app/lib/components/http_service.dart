import 'dart:convert';

import 'package:garbidz_app/components/address_model.dart';
import 'package:garbidz_app/components/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class HttpService{
  static String token="";
  final String postsUrl = "http://"+globals.uri+"/api/addresses/all";
  Future <List<Address>> getPosts()async{
    final res = await http.get(
        Uri.parse(postsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8',
        });

    if(res.statusCode == 200){
      try{
        final decoded = jsonDecode(res.body);
        List<dynamic> body = decoded;

        List<Address> addresses = body.map((dynamic item) => Address.fromJson(item)).toList();
        return addresses;
      }catch(e){
        print(e);
      }
    }
    else{
      throw "Can't get posts.";
    }
  }
}